LOGDIR="/var/log/ssh"
mkdir -p "$LOGDIR"
LOGFILE="$LOGDIR/$(date '+%Y%m%d-%H%M%S')-$(whoami).log"

if [ -n "$SSH_ORIGINAL_COMMAND" ]; then
    echo "$(date '+%Y%m%d-%H%M%S') - Executing: $SSH_ORIGINAL_COMMAND" >> "$LOGFILE"
    # Redirect output and error to the log file and also send to the client
    exec bash -c "$SSH_ORIGINAL_COMMAND" 2>&1 | tee -a "$LOGFILE"
else
    exec script -q -f -c "/bin/bash" "$LOGFILE"
fi

