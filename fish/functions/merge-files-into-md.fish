function merge-files-into-md --description "Merge files matching glob pattern(s) into a single Markdown file"
    # Usage:
    #   merge-files-into-md [--output FILE] [PATTERN...]
    # Defaults: output = combined_code.md, pattern = *.ts
    # Examples:
    #   merge-files-into-md '*.ts'
    #   merge-files-into-md --output all.md '*.ts' '*.js'
    #
    # Note: quote the pattern so the shell passes it through to `find`
    # (fish errors on unmatched unquoted globs). Patterns are matched
    # recursively and skip node_modules. Literal existing paths also work.
    argparse --name merge-files-into-md 'o/output=' -- $argv
    or return

    set -l output $_flag_output
    if test -z "$output"
        set output combined_code.md
    end

    set -l patterns $argv
    if test (count $patterns) -eq 0
        set patterns '*.ts'
    end

    # Collect matching files (recursive, skip node_modules), dedupe, sort
    set -l files
    for p in $patterns
        if test -e "$p"
            set -a files $p                       # literal existing path(s)
        else
            set -a files (find . -name "$p" -not -path "*/node_modules/*" 2>/dev/null)
        end
    end
    set -l files (printf '%s\n' $files | sort -u)

    # Write header
    printf '# Merged source files\n\n' > $output

    set -l count 0
    for file in $files
        if not test -f "$file"
            continue
        end

        # Pick a fence language from the file extension
        set -l ext (string lower (string split -r -m1 . -- "$file")[-1])
        set -l fence text
        switch $ext
            case ts tsx;        set fence typescript
            case js jsx mjs cjs; set fence javascript
            case json;          set fence json
            case md;            set fence markdown
            case sh fish bash;  set fence bash
            case py;            set fence python
            case rs;            set fence rust
            case go;            set fence go
        end

        echo "## File: $file" >> $output
        echo '```'(echo $fence) >> $output
        cat "$file" >> $output
        echo '```' >> $output
        echo "" >> $output
        set count (math $count + 1)
    end

    echo "Merged $count file(s) into $output"
end
