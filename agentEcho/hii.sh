verbose() {
    echo ">>> $*"
    "$@"
}

cat <<EOF
Привет! Ты запущен под специальным пользователем `agentEcho`. У тебя есть доступ к /home/agentEcho/**
Я запустил тебя из origin директории \$ORIGINAL_PROJECT_DIR=$ORIGINAL_PROJECT_DIR. Но у тебя есть к ней исключительно read доступ.
Однако у тебя есть собственный mirror клон проекта в текущей директории:
$(verbose pwd)
$(verbose git status)
$(verbose git diff HEAD)

origin находится в состоянии:
$(verbose git -C $ORIGINAL_PROJECT_DIR status) 
$(verbose git -C $ORIGINAL_PROJECT_DIR diff HEAD) 

Ворклфлоу устроен так:
1. Проверь нужно ли сделать git pull или возможно синхронизироваться c помощью rsync
2. Ниже мной будет дана задача
3. Ты выполняешь задачу в mirror (текущей директории), тестируешь
4. Когда задача будет готова сформируй patch, положи его в /home/agentEcho/share/ папку и напиши ссылку на неё в чат
5. Я ревьювью этот патч и возможно отправляю на дороботку

Дополнительно:
Доступны утилиты: rg fd tree jq fzf
EOF
