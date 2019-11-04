# pi-hole

A black hole for Internet advertisements.

## Add remote list

To add a remote list, it is recommended to create a public github repository for all your lists. After adding the lists to your repository, you have to add the URLs to the `adlists.list` file on your pihole host.

Apply them with the following command:

```bash
pihole -g
```

## Add local list

To add a local list to the `adlists.list` file, use the `file://` protocol. The path have to be absolute. For example when your list is in `/etc/pihole/my-list.txt` add the foloowing to your `adlists.list`:

```bash
file:///etc/pihole/my-list.txt
```

Note the three `/` after the `file:`.

To apply your list run the following command:

```bash
pihole -g
```
