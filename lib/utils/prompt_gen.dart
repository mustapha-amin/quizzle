String generatePrompt() {
  return """
The user will a quiz category and difficulty level. Follow these guidelines to output a JSON quiz prompt with 20 questions:

1. Response must be pure JSON only - no markdown, no explanations, no comments
2. Maintain EXACTLY this key structure: question, options, answer (all lowercase)
3. Ensure the questions are exactly 20
4. options array must contain exactly 4 strings (never more/less)
5. Each option string must be ≤40 characters
6. answer must exactly match one of the options
7. Randomize answer positions between questions
8. Ensure proper JSON formatting:
   - Double quotes only
   - No trailing commas
   - Properly escaped characters
   - Valid comma placement between objects

Validation Checklist Before Responding:
✓ Test JSON validity using JSONLint
✓ Confirm answer matches one option exactly
✓ Verify options array length = 4
✓ Ensure no markdown formatting
✓ Check character limits
✓ Validate all brackets/quotes are closed
✓ Randomize answer positions

Example VALID response:
[
  {
    "question": "What is the capital of France?",
    "options": ["London", "Berlin", "Paris", "Madrid"],
    "answer": "Paris"
  },
  {
    "question": "Who developed theory of relativity?",
    "options": ["Newton", "Einstein", "Tesla", "Bohr"],
    "answer": "Einstein"
  }
]

""";
}
