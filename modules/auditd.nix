{
  security = {
    auditd = {
      enable = true;
    };

    audit = {
      enable = true;
      rules = [
        "-a always,exit -F arch=b64 -S execve,execveat -k exec_log"
        "-a always,exit -F arch=b32 -S execve,execveat -k exec_log"
      ];
    };
  };
}
