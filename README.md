# SFTP Docker Container README

Welcome to the SFTP Docker Container project! This README is designed to help you understand how to build and run the SFTP Docker container. Please follow the instructions below for a seamless experience. 

## !! IMPORTANT: Password Policy

All passwords must adhere to the following criteria:

- At least 15 characters long
- Contain at least one numerical digit
- Contain at least one lowercase letter
- Contain at least one uppercase letter

Failure to meet these criteria will result in an error. Make sure to verify your passwords against these rules before proceeding.

## Table of Contents

- [Quick Start](#quick-start)
- [Build Arguments](#build-arguments)
- [Environment Variables](#environment-variables)
- [Adding SSH Public Keys](#adding-ssh-public-keys)
- [Notes](#notes)
- [License](#license)

---

## Quick Start

To build the Docker image:

```bash
docker build --build-arg PERMIT_PASSWORD_LOGIN=false -t your_image_name .
```

To run the Docker container:
**Note: Ensure your passwords follow the [Password Policy](#important-password-policy) before running these commands.**
```bash
docker run -e MASTER_PASSWORD="YourMasterPassword123" -e SSH_USERS="user1:YourPassword123,user2:YourPassword123" your_image_name
```

---

## Build Arguments

- **`PERMIT_PASSWORD_LOGIN`**: Enable or disable password login. The value can either be `true` or `false`. The default value is `false`.

Example:

```bash
--build-arg PERMIT_PASSWORD_LOGIN=true
```

---

## Environment Variables

### At Runtime

**Note: Ensure your passwords follow the [Password Policy](#important-password-policy).**

- **`MASTER_PASSWORD`**: The password for the master user. The master user is created during the build and is named `sftp-user` by default. This user can SSH into the container.
  
  - **Example**: `-e MASTER_PASSWORD="YourMasterPassword"`

- **`SSH_USERS`**: Define additional SSH users and their passwords. This environment variable expects either a single `"user:password"` pair or a comma-separated list like `"user:password,user1:password"`.

  - **Example**: `-e SSH_USERS="user1:password,user2:password"`

---

## Adding SSH Public Keys

If you want to add SSH public keys for a user, you can do so by passing an environment variable following the pattern `SSH_PUB_{USERNAME_IN_UPPERCASE}`.

For example, if the user name is `teste1`, you would pass:

- **`SSH_PUB_TESTE1`**: This would contain the public SSH key and it will be placed in `/home/teste1/.ssh/authorized_keys`.

  - **Example**: `-e SSH_PUB_TESTE1="ssh-rsa AAAAB3Nz..."`

---

## Notes

- Please be cautious when using special characters like `:`, `$` etc., as they might be interpreted differently by YAML.

---

## Troubleshooting

- Uncomment line 3 in entrypoint:

    ```
    #set -x
    ```

---

## Contact

- E-mail: rrmmbmg903@gmail.com
- Linkedin: https://www.linkedin.com/in/rafael-rodrigues-marques-42305a20a/

---

## License

This project is licensed under the Apache-2.0 License - see the [LICENSE.md](LICENSE.md) file for details.

---

Thank you for using the SFTP Docker Container! If you encounter any issues or have further questions, please open an issue.
