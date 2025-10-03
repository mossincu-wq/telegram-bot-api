import os
from telegram import Update
from telegram.ext import Updater, CommandHandler, MessageHandler, Filters, CallbackContext

# Replace 'YOUR_TOKEN_HERE' with your actual bot token
TOKEN = os.environ.get('TELEGRAM_BOT_TOKEN')

def start(update: Update, context: CallbackContext) -> None:
    update.message.reply_text('Hello! Send me a document or file, and I will download it.')

def download_file(update: Update, context: CallbackContext) -> None:
    downloaded_files = []

    # Check if the message contains documents or media
    if update.message.document:
        files = [update.message.document]
    elif update.message.photo:
        files = update.message.photo[-1:]  # Get the highest resolution photo
    elif update.message.audio:
        files = [update.message.audio]
    elif update.message.video:
        files = [update.message.video]
    else:
        update.message.reply_text('Unsupported file type. Please send documents or media files.')
        return

    # Download each file
    for file in files:
        file_path = os.path.join(os.path.realpath('.'), 'files', file.file_name)
        # file_path = os.path.join(os.getcwd(), file.file_name)
        new_file = context.bot.getFile(file.file_id)
        new_file.download(file_path)
        downloaded_files.append(file.file_name)

    # Notify the user about the downloaded files
    if downloaded_files:
        update.message.reply_text(f'Downloaded files: {", ".join(downloaded_files)}')
def main() -> None:
    updater = Updater(TOKEN, base_url='https://telegram-bot-api-vf8z.onrender.com/bot')
    # print(dir(Updater))

    dispatcher = updater.dispatcher

    dispatcher.add_handler(CommandHandler("start", start))
    # dispatcher.add_handler(MessageHandler(Filters.document, download_file))
    dispatcher.add_handler(MessageHandler(Filters.document | Filters.photo | Filters.audio | Filters.video, download_file))
    print('polling...')


    updater.start_polling()
    updater.idle()

if __name__ == '__main__':
    main()
