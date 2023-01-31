#!/bin/bash

while read line; do
  key=$(echo $line | cut -d '=' -f 1)
  value=$(echo $line | cut -d '=' -f 2)
#!/bin/bash

while read line; do
  key=$(echo $line | cut -d '=' -f 1)
  value=$(echo $line | cut -d '=' -f 2)

  if [ "$value" = "prompt" ]; then
    # Keep prompting for passwords until they match
    while true; do
      echo -n "Enter a password for $key: "
      read password
      echo -n "Verify password: "
      read verify
      if [ "$password" = "$verify" ]; then
        # Passwords match, exit loop
        break
      else
        # Passwords do not match, print a message and continue loop
        echo "Passwords do not match. Please try again."
      fi
    done

    value=$(echo -n $password | openssl passwd -apr1)
    docker secret update "$key" - <<< "$value"
    if [ "$key" = "TRAEFIK_HASHED_PASSWORD" ]; then
      echo "This password will be used to access $key and should be stored."
      echo "Press Enter to acknowledge..."
      read
    fi
  elif [ "$value" = "encrypt" ]; then
    value=$(openssl rand -base64 32)
    docker secret update "$key" - <<< "$value"
  fi
done < /opt/$PROJECT_NAME/secrets.env


