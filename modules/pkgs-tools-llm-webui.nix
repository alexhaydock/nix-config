{
  # Starts an open-webui server on http://localhost:8080/
  services.open-webui.enable = true;

  # Lower the priority of the service to avoid
  # harming system responsiveness (it can get
  # quite heavy when loading knowledge files etc.)
  systemd.services.open-webui = {
    serviceConfig = {
      IOSchedulingPriority = 7; # Set disk IO priority to the lowest available value
      Nice = 19; # Be quite willing to yield to other processes for CPU time
    };
  };
}
