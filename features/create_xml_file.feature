Feature: Generate XML file from videos

  As a user
  I want build an XML file of all my videos
  So that I can have a UI with rich content for my videos

	Scenario: Run the script from the command line
    # Given 
	  When I run `roksbox-xml`
	  Then the output should contain:
	    """
	    Generating XML file from videos...
	    """
	  And the output should not contain "something I don't wanted printed"