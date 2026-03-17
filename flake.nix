{
  description = "Banking Bot - Multi-platform Dev Environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    # flake-utils giúp tự động hóa việc hỗ trợ nhiều hệ điều hành
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        pythonVersion = "3.11";
        pythonDeps = [
          "fastapi[standard]"
          "uvicorn"
          "langchain"
          "langchain-openai"
          "pypdf"
          "python-dotenv"
          "deepeval"
        ];
      in {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            python311
            uv
            openssl
            pkg-config
            libiconv
          ] ++ (pkgs.lib.optionals pkgs.stdenv.isDarwin [
            pkgs.darwin.apple_sdk.frameworks.Security # Cần cho macOS
          ]);

          shellHook = ''
            echo "🚀 Banking Bot: Declarative Shell Loading..."

            # TRICK QUAN TRỌNG: Ép uv sử dụng Python từ Nix Store thay vì tự tải
            export UV_PYTHON=${pkgs.python311}/bin/python3
            # Ngăn uv tự ý tải các bản Python không tương thích với NixOS
            export UV_PYTHON_DOWNLOADS=never
            
            # 1. Khởi tạo dự án uv nếu chưa có (không tương tác)
            if [ ! -f "pyproject.toml" ]; then
              echo "Initializing pyproject.toml..."
              uv init --lib --no-workspace $UV_PYTHON
            fi

            # 2. Đồng bộ hóa Python version và Dependencies từ Flake vào pyproject.toml
            # Chúng ta dùng 'uv add' để đảm bảo file TOML luôn đúng format và có lockfile
            echo "Syncing dependencies from Flake to pyproject.toml..."
            uv python pin ${pythonVersion}
            # Dùng --no-sync để chỉ cập nhật file toml, việc cài đặt để bước sau
            uv add --no-sync ${pkgs.lib.concatStringsSep " " pythonDeps}

            # 3. Thiết lập Virtual Env
            if [ ! -d ".venv" ]; then
              uv venv
            fi
            source .venv/bin/activate
            
            # 4. Final sync để đảm bảo môi trường khớp 100% với lockfile
            uv sync

            echo "✅ Môi trường đã sẵn sàng. Hệ thống đã khóa phiên bản tại uv.lock"
          '';
        };
      });
  # {
  #   packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;
  #   packages.x86_64-linux.default = self.packages.x86_64-linux.hello;
  # };
}
