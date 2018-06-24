class Rule {
	char character;
	String rule;
	Rule(char c, String s) {
		character = c;
		rule = s;
	}

	char getCharacter() {
		return character;
	}

	String getRule() {
		return rule;
	}
}


class LSystem {

	String sentence;
	Rule[] ruleset;
	int generation;

	LSystem(String ax, Rule[] rules) {
		sentence = ax;
		ruleset = rules;
		generation = 0;
	}

	String getSentence() {
		return sentence;
	}

	void generate() {
		StringBuffer next = new StringBuffer();
		for(int i = 0; i < sentence.length() ; i++) {
			char c = sentence.charAt(i);
			String replace = "" + c;
			for(int j = 0 ; j < ruleset.length ; j++) {
				if(c == ruleset[j].getCharacter()) {
					replace = ruleset[j].getRule();
					break;
				}
			}
			next.append(replace);
		}
		sentence = next.toString();
		generation++;
	}

	int getGeneration() {
		return generation;
	}
}
