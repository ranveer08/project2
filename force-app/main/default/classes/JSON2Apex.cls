public class JSON2Apex {
    public class Authors {
        public String url {get;set;} 
        public String name {get;set;} 
        
        public Authors(JSONParser parser) {
            while (parser.nextToken() != System.JSONToken.END_OBJECT) {
                if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
                    String text = parser.getText();
                    if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
                        if (text == 'url') {
                            url = parser.getText();
                        } else if (text == 'name') {
                            name = parser.getText();
                        } else {
                            System.debug(LoggingLevel.WARN, 'Authors consuming unrecognized property: '+text);
                            //Authors(parser);
                        }
                    }
                }
            }
        }
    }
    
}