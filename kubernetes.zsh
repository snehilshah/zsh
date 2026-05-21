#!/usr/bin/env zsh
# =========================================================
# Kubernetes (kubectl) Autocomplete, Aliases & FZF Helpers
# =========================================================

# Check if kubectl is installed on the system
if command -v kubectl >/dev/null 2>&1; then

  # 1. Native autocompletion (fast inline loading)
  source <(kubectl completion zsh)

  # 2. Standard convenient aliases
  alias k="kubectl"
  alias kg="kubectl get"
  alias kd="kubectl describe"
  alias ke="kubectl edit"

  # 3. Premium Interactive FZF Helpers

  # kl (Kubectl Logs): Tail logs of an FZF-selected pod (optionally filtered by namespace)
  kl() {
    local namespace="${1}"
    local pod
    
    if [[ -n "$namespace" ]]; then
      # List only pods in the specified namespace
      pod=$(kubectl get pods -n "$namespace" --no-headers 2>/dev/null \
        | awk '{print $1}' \
        | fzf --prompt="Select Pod in $namespace: " --height=40% --layout=reverse --border </dev/tty)
    else
      # List pods from all namespaces and parse selected namespace + pod name
      local selected=$(kubectl get pods --all-namespaces --no-headers 2>/dev/null \
        | fzf --prompt="Select Pod (All Namespaces): " --height=40% --layout=reverse --border </dev/tty)
      [[ -z "$selected" ]] && return 0
      namespace=$(echo "$selected" | awk '{print $1}')
      pod=$(echo "$selected" | awk '{print $2}')
    fi
    
    [[ -z "$pod" ]] && return 0
    
    echo -e "Tailing logs for \e[1;33m$pod\e[0m in namespace \e[1;36m$namespace\e[0m..." >&2
    kubectl logs -n "$namespace" -f "$pod"
  }

  # kx (Kubectl Exec): Exec shell in an FZF-selected pod (optionally filtered by namespace)
  kx() {
    local namespace="${1}"
    local pod
    
    if [[ -n "$namespace" ]]; then
      # List only pods in the specified namespace
      pod=$(kubectl get pods -n "$namespace" --no-headers 2>/dev/null \
        | awk '{print $1}' \
        | fzf --prompt="Select Pod for Shell in $namespace: " --height=40% --layout=reverse --border </dev/tty)
    else
      # List pods from all namespaces and parse selected namespace + pod name
      local selected=$(kubectl get pods --all-namespaces --no-headers 2>/dev/null \
        | fzf --prompt="Select Pod for Shell (All Namespaces): " --height=40% --layout=reverse --border </dev/tty)
      [[ -z "$selected" ]] && return 0
      namespace=$(echo "$selected" | awk '{print $1}')
      pod=$(echo "$selected" | awk '{print $2}')
    fi
    
    [[ -z "$pod" ]] && return 0
    
    echo -e "Opening interactive shell in \e[1;33m$pod\e[0m (namespace: \e[1;36m$namespace\e[0m)..." >&2
    kubectl exec -n "$namespace" -it "$pod" -- /bin/sh || kubectl exec -n "$namespace" -it "$pod" -- /bin/bash
  }

fi
