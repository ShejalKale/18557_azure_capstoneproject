# 18557_azure_capstoneproject

This repository contains Terraform configuration for the capstone project infra.

How to publish to GitHub

1. Create a GitHub repository (see options below).
2. Add a remote and push the `main` branch:

   - Using `gh` (GitHub CLI): `gh repo create <name> --public --source=. --remote=origin --push`
   - Or manually: create repo on github.com, then run `git remote add origin <URL>` and `git push -u origin main`.

Notes

- Do not commit Terraform state files (`*.tfstate`). Keep them remote in a secure backend (e.g., Azure Storage).
- Adjust visibility (`--public` / `--private`) when creating the repo.

