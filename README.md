# java-25-utility-container

A Docker image with JDK 25 and Maven, so you can compile, test, package, and run
Java/Maven projects without installing either on your host. Your source stays on
the host and is bind-mounted into the container at `/workspace`.

## Build the image

```powershell
docker build -t java25-utility .
```

## Verify the toolchain

```powershell
docker run --rm java25-utility java -version
docker run --rm java25-utility mvn -version
```

## Use it with your source code

Run these from the root of the project you want to build (the directory
containing `pom.xml`). It is mounted at `/workspace`.

PowerShell (Windows):

```powershell
docker run --rm -it -v "${PWD}:/workspace" -v m2-cache:/root/.m2 java25-utility
```

Bash (Linux/macOS/Git Bash):

```bash
docker run --rm -it -v "$(pwd):/workspace" -v m2-cache:/root/.m2 java25-utility
```

This opens a shell inside the container. Inside it:

```bash
mvn compile
mvn test
mvn package
java -jar target/<your-artifact>.jar
```

Or run a single command without opening a shell:

```powershell
docker run --rm -v "${PWD}:/workspace" -v m2-cache:/root/.m2 java25-utility mvn clean package
```

Notes:

- `-v m2-cache:/root/.m2` is a named volume that caches downloaded Maven
  dependencies between runs. Omit it if you don't want caching.
- Build output (e.g. `target/`) is written to your host through the bind mount.
  On Linux, files created by the container are owned by root; add
  `--user "$(id -u):$(id -g)"` if that is a problem.
- To reach a server started in the container from the host, add `-p 8080:8080`.
