# Зависимости

Конфиг рассчитан на Neovim 0.9+; плагины устанавливает `lazy.nvim` при первом запуске. Нужны Git и доступ к GitHub.

Форматтеры необязательны: без них редактор работает, но не будет форматировать соответствующие типы файлов.

| Тип файлов | Команда |
| --- | --- |
| Lua | `stylua` |
| Python | `black` |
| JavaScript / TypeScript / JSON | `prettier` |
| T-SQL | `sql-formatter` |

## Git Bash на Windows

В Git Bash выполните:

```bash
winget.exe install --id Neovim.Neovim -e
winget.exe install --id Git.Git -e
winget.exe install --id Python.Python.3.14 -e
winget.exe install --id OpenJS.NodeJS.LTS -e
winget.exe install --id JohnnyMorganz.StyLua -e

python -m pip install --user black
npm install -g prettier sql-formatter
```

Чтобы Neovim видел пользовательские Python- и npm-команды, добавьте их в `PATH` Git Bash:

```bash
echo 'export PATH="$PATH:$(cygpath -u "$(python -m site --user-base)")/Scripts:$(cygpath -u "$APPDATA")/npm"' >> ~/.bashrc
source ~/.bashrc
```

Для автоматического переключения раскладки нужен необязательный `im-select.exe`. Конфиг ищет его в `C:/im-select/im-select.exe` либо по переменной `IM_SELECT_PATH`:

```bash
export IM_SELECT_PATH=/c/im-select/im-select.exe
```

Встроенный терминал использует `bash.exe`; Git for Windows уже предоставляет его.

## Bash на Ubuntu

```bash
sudo apt update
sudo apt install -y neovim git curl python3-pip nodejs npm cargo

python3 -m pip install --user black
npm install -g prettier sql-formatter
cargo install stylua
```

Добавьте пользовательские бинарники в `PATH`:

```bash
echo 'export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$(npm prefix -g)/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

На Ubuntu внешний терминал использует установленный системный `bash`; `im-select` не требуется.

## Проверка

После запуска Neovim выполните:

```vim
:Lazy
:ConformInfo
```

В `:ConformInfo` доступные программы отображаются как `ready`. Для SQL должен быть доступен `mssql` / `sql-formatter`.
