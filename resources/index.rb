require "appwrite"

def main(context)
    return context.res.json(
        {
          "motto": "Build like a team of hundreds_",
          "learn": "https://appwrite.io/docs",
          "connect": "https://appwrite.io/discord",
          "getInspired": "https://builtwith.appwrite.io",
        }
      )
end