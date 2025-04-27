# Fawry Internship - DevOps Tasks

This repo contains on my solutions for the the DevOps internship at Fawry. Below are the two tasks and their solutions.

![Example of -n option output](/img/fawry.png)

## Table of Contents
1. [Task 1: Custom Command (mygrep.sh)](#Task-1-custom-command-mygrepsh)
2. [Task 2: Troubleshooting Network Issue](#Task-2-troubleshooting-network-issue)

---

# Task-1-custom-command-mygrepsh

This script is a mini version of the `grep` command that allows searching for strings in a text file, with additional options like showing line numbers, inverting matches, and more.

## Command-Line Options:

- `-n` → Show line numbers for each match.
  
    Example usage:
    ```bash
    ./mygrep.sh -n hello testfile.txt
    ```
    This will search for the string `hello` in the `testfile.txt` file and display the matching lines with their line numbers.
    ![Example of -n option output](/img/mygrep.png)

- `-v` → Invert the match (print lines that **do not** match).
  
    Example usage:
    ```bash
    ./mygrep.sh -v hello testfile.txt
    ```
    This will search for all lines that do **not** contain the string `hello` in the `testfile.txt` file.
    ![Example of -n option output](/img/mygrep.png)

- Combinations like `-vn`, `-nv` → Using `-v` and `-n` together will show the lines that do **not** match and display the corresponding line numbers.
  
    Example usage:
    ```bash
    ./mygrep.sh -vn hello testfile.txt
    ```
    This will display lines that do not match `hello` with their line numbers.
    ![Example of -n option output](/img/mygrep.png)

- `--help` → Display usage instructions for the script.

    Example usage:
    ```bash
    ./mygrep.sh --help
    ```
    This will show the following help message:
    ```
    Usage: ./mygrep.sh [options] <search-string> <file>
    Options:
      -n          Show line numbers for each match.
      -v          Invert the match (print lines that do not match).
      --help      Display this help message.
![Example of -n option output](/img/mygrep.png)


## Reflective Section:

1. **How the script handles arguments and options**:  
   The script uses `getopts` to handle the command-line options. Each option (`-n`, `-v`, `--help`) is processed in sequence, with appropriate error handling for invalid input or missing arguments.
   
2. **If supporting regex or -i/-c/-l options**:  
   Supporting regex would involve updating the search functionality to support pattern matching, which can be done using tools like `grep -P` or adjusting the logic in the script. For `-i`, you could add case-insensitive searching, and `-c` or `-l` would require modifying how matches are counted or displayed.
   
3. **Hardest part to implement**:  
   The most challenging part was ensuring the `-v` and `-n` options worked together properly, particularly when handling edge cases like empty or missing input files.

## Bonus:

- I added support for the `--help` flag to provide usage information.
- I improved option parsing using `getopts`.



### How to use mygrep script ? 

#### **Commands:**
   ```bash
   # clone the repo
   git clone https://github.com/Alien166/fawry-internship-task.git

   # change the Permission
   chmod +x mygrep.sh
   
   # test it with this examples 

   ./mygrep.sh hello testfile.txt

   ./mygrep.sh -n hello testfile.txt

   ./mygrep.sh -v hello testfile.txt

   ```

...

---

# Task-2-troubleshooting-network-issue

This task involves troubleshooting connectivity issues for an internal web dashboard hosted on `internal.example.com`. The service appears to be up, but users are getting “host not found” errors.

## Tshooting Steps:

### 1. **Verify DNS Resolution**
   The first step is verifying DNS resolution. We will compare DNS resolution using the local DNS server specified in `/etc/resolv.conf` and Google's DNS server (`8.8.8.8`).

#### **Problem:**
   - The first check shows that the service is unreachable, possibly due to an issue with the DNS resolution.

#### **Commands:**
   ```bash
   # Check DNS resolution using local DNS
   nslookup internal.example.com
   
   # Check DNS resolution using Google DNS
   nslookup internal.example.com 8.8.8.8
   ```

![Example of -n option output](/img/nslookup-2.png)
   

### 2. **Diagnose Service Reachability**
   to check if the web service is actually reachable.

#### **Problem:**
   1- DNS may resolve correctly but service might not be responding

   2- Need to verify if web server is listening on expected ports

#### **Commands:**
   ```bash
   # Check basic TCP connectivity
   telnet internal.example.com 80
   
   # Test HTTP connection
   curl -v http://internal.example.com
   ```
![Example of -n option output](/img/nslookup-2.png)



### 3. **Verify DNS Configuration in /etc/resolv.conf**

#### **Problem:**
   The DNS resolution might be affected by incorrect entries in the /etc/resolv.conf file. We need to ensure the file contains valid DNS server entries.

#### **Commands:**
   ```bash
   # View the DNS configuration
   cat /etc/resolv.conf
   ```

#### The /etc/resolv.conf file contains the DNS servers that the system uses to resolve domain names. If it's empty or incorrectly configured, DNS resolution will fail.   

![Example of -n option output](/img/resolv-1.png)


### 4. **Use /etc/hosts for Temporary DNS Resolution**

we can temporarily add the domain and IP address mapping in the /etc/hosts file to bypass DNS resolution and check if the service is reachable.

#### **Commands:**
   ```bash
   # Edit the /etc/hosts file
   sudo nano /etc/hosts
   ```

Add an entry to map internal.example.com to the corresponding IP address in /etc/hosts

![Example of -n option output](/img/hosts.png)

#### After adding the entry, test if the service is reachable again by using ping or curl.

**Bonus**:
- I have Configure a local `/etc/hosts` entry to bypass DNS for testing.

## Summary of Solutions:

1. **DNS Resolution**: The issue may be caused by misconfigured DNS settings. Verify DNS resolution using local and external DNS servers.

2. **Service Reachability**: Ensure the service is accessible on the correct port (e.g., port 80 for HTTP).

3. **Hosts File**: Use the `/etc/hosts` file as a temporary workaround for DNS resolution issues.

4. **Detailed DNS Queries**: Use `dig` for more detailed insights into DNS issues.


### Special Thanks:
I would like to express my sincere gratitude to the Fawry team for designing these tasks, which helped me enhance my technical skills. I'm grateful for the opportunity to work on such practical and insightful challenges.
