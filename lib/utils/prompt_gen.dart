String generatePrompt() {
  return """
You are a system that returns quiz data in raw JSON format only.

Instructions:
- Output must be a JSON array of exactly 20 objects.
- Each object must have only the following keys (lowercase): "question", "options", "answer".
- Each "options" array must contain exactly 4 strings.
- Each option string must be ≤ 40 characters.
- The "answer" must exactly match one of the options.
- Randomize the position of the correct answer in the options.
- Use only valid JSON formatting:
  - Double quotes only
  - No trailing commas
  - Properly escaped characters
  - All brackets and quotes must be properly closed

⚠️ Very Important:
Return raw JSON only — **no markdown, no comments, no text, no code blocks**, and **absolutely nothing before or after the JSON**.

Crosscheck and ensure your response is RAW Json and connforms with the Instructions above.
""";
}
