# bandcamp_mailclerk

Handles incoming purchase notification emails from bandcamp and downloads contents. No bandcamp credentials required.

Docker container is published as **r0nd/bandcamp_mailclerk**

Example k8s configuration:

```
apiVersion: v1
kind: Pod
metadata:
  name: bandcamp-mailclerk-pod
  labels:
    app: bandcamp-mailclerk
spec:
  containers:
    - name: bandcamp-mailclerk
      image: r0nd/bandcamp_mailclerk:latest
      env:
        - name: EMAIL
          value: username@gmail.com
        - name: IMAP_HOST
          value: imap.gmail.com
        - name: MAIL_PWD
          value: password
        - name: QUERY
          value: 'UNSEEN FROM noreply@bandcamp.com SUBJECT "Thank you!"'
      volumeMounts:
        - mountPath: /output
          name: music-volume
  volumes:
    - name: music-volume
      nfs:
        server: media_server
        path: /music/folder/path
  restartPolicy: OnFailure
```
