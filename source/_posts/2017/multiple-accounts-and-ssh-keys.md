---
layout: default
title:  "Multiple Accounts and SSH Keys"
date:   2017-09-25 16:02:34 +0700
key: 20170925
tags:
  - ssh
  - tips
lang: en
---

Multiple SSH keys
Problem is, Bitbucket doesn’t allow you to use the same SSH key with more than one Bitbucket account. I still have my old work account to tidy up loose ends.

As GitHub explains you can generate an SSH key like so:

```bash
cd ~/.ssh
ssh-keygen -t rsa -C "your_email@youremail.com"

```

You are then prompted for an optional password. After the key is generate you copy & paste it into your GitHub or Bitbucket account settings. On Mac OS X (10.8), which I’m using, copying to the clipboard is simple:

```bash
pbcopy < ~/.ssh/id_rsa.pub
```

With multiple Bitbucket accounts (and I assume GitHub too) you need multiple SSH keys. To generate a second key with a different name:

```bash
ssh-keygen -t rsa -f ~/.ssh/accountB -C "your_email@youremail.com"
```

To use multiple keys create a file at ~/.ssh/config with contents similar to:

```bash
Host bitbucket.org
  User git
  Hostname bitbucket.org
  PreferredAuthentications publickey
  IdentityFile ~/.ssh/id_rsa

Host bitbucket.accountB
  User git
  Hostname bitbucket.org
  PreferredAuthentications publickey
  IdentitiesOnly yes
  IdentityFile ~/.ssh/accountB

```

With this set up I can clone with my default key as Bitbucket suggests:

```bash
git clone git@bitbucket.org:username/project.git
```

If I want to clone a repository from my second account I can alter the command to use the second SSH key I generated:

```bash
git clone git@bitbucket.accountB:username/project.git
```

In fact, if I wanted to I could have a different SSH key for every account I have; GitHub, Bitbucket, or any other service that requires one.


