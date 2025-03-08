{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = [
    pkgs.cargo
    pkgs.rust-analyzer
  ];

  shellHook = ''
    echo -e "\033[34mCreating .telescopeignore and .gitignore if not done already...\034[0m"

    # Function to check if a line exists in a file
    lineinfile() {
        local file="$1"
        local line="$2"
        
        if [ ! -f "$file" ]; then
            touch "$file"
        fi
        
        if ! grep -q -F "$line" "$file"; then
            echo "$line" >> "$file"
            echo -e "\033[35m    Added '$line' to $file\033[0m"
        else
            echo -e "\033[33m    '$line' already exists in $file, doing nothing."
        fi
    }

    # telescope
    lineinfile ".telescopeignore" ".git/"

    # gitignore
    lineinfile ".gitignore" "debug/"
    lineinfile ".gitignore" "target/"

    echo -e "\033[34m\nDone!\033[0m"
  '';
}
