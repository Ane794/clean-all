#!/usr/bin/env bash

# 白名單文件相對路徑
whitelistFile=.whitelist.txt

for file in $(find . -maxdepth 1 -not -iname . | tr ' ' '?'); do  # 列出目錄下所有文件.
  file=${file#./}
  file=${file//'?'/' '}

  flag=true
  while read -r line; do
    if [ "$file" == "$line" ]; then  # 于白名單查找.
      flag=false
      break
    fi
  done < $whitelistFile
  unset line

  if [ $flag == false ]; then
    echo "[skip] $file"
    continue
  else
    echo "[del] $file"
    rm -r "$file" || echo "ERROR!"
  fi
  unset flag
done
unset file

unset whitelistFile
