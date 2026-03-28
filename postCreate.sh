{
  "name": "Prof AYA - Flutter Development",
  "image": "mcr.microsoft.com/devcontainers/universal:2-linux",
  "features": {
    "ghcr.io/devcontainers/features/docker-outside-of-docker:1": {},
    "ghcr.io/devcontainers/features/git:1": {}
  },
  "customizations": {
    "vscode": {
      "extensions": [
        "Dart-Code.flutter",
        "Dart-Code.dart-code",
        "esbenp.prettier-vscode",
        "ms-vscode.makefile-tools"
      ],
      "settings": {
        "dart.flutterSdkPath": "/opt/flutter",
        "editor.formatOnSave": true,
        "editor.defaultFormatter": "Dart-Code.dart-code",
        "[dart]": {
          "editor.defaultFormatter": "Dart-Code.dart-code",
          "editor.formatOnSave": true
        }
      }
    }
  },
  "remoteEnv": {
    "PATH": "/opt/flutter/bin:${PATH}"
  },
  "forwardPorts": [8080],
  "postCreateCommand": "bash .devcontainer/postCreate.sh",
  "remoteUser": "codespace"
}
