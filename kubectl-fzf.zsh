# Kubectl fzf integrations
function kpod() {
  local pod=$(kubectl get pods --no-headers -o custom-columns=":metadata.name" | fzf --prompt="Select Pod: " --height=40% --reverse)
  if [[ -n $pod ]]; then
    echo $pod
  fi
}

function kdesc() {
  local resource_type="${1:-pod}"
  local resource=$(kubectl get $resource_type --no-headers -o custom-columns=":metadata.name" | fzf --prompt="Select $resource_type: " --height=40% --reverse)
  if [[ -n $resource ]]; then
    kubectl describe $resource_type $resource
  fi
}

function klogs() {
  local pod=$(kubectl get pods --no-headers -o custom-columns=":metadata.name" | fzf --prompt="Select Pod for logs: " --height=40% --reverse)
  if [[ -n $pod ]]; then
    local follow_flag=""
    local use_pino=""
    
    # Parse arguments
    for arg in "$@"; do
      case $arg in
        f|follow)
          follow_flag="-f"
          ;;
        p|pretty|pino)
          use_pino="true"
          ;;
      esac
    done
    
    # Build the command
    local cmd="kubectl logs $pod $follow_flag"
    
    if [[ $use_pino == "true" ]]; then
      if command -v pino-pretty >/dev/null 2>&1; then
        eval "$cmd | pino-pretty"
      else
        echo "Warning: pino-pretty not found, showing raw logs"
        eval "$cmd"
      fi
    else
      eval "$cmd"
    fi
  fi
}

function kexec() {
  local pod=$(kubectl get pods --no-headers -o custom-columns=":metadata.name" | fzf --prompt="Select Pod to exec into: " --height=40% --reverse)
  if [[ -n $pod ]]; then
    kubectl exec -it $pod -- "${@:-/bin/bash}"
  fi
}

function kns() {
  local namespace=$(kubectl get namespaces --no-headers -o custom-columns=":metadata.name" | fzf --prompt="Select Namespace: " --height=40% --reverse)
  if [[ -n $namespace ]]; then
    kubectl config set-context --current --namespace=$namespace
    echo "Switched to namespace: $namespace"
  fi
}
