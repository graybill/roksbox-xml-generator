Feature: Generate XML file from videos

  As a user
  I want build an XML file of all my videos
  So that I can have a UI with rich content for my videos

	Scenario: Run the script from the command line
	  When I run "ruby roksbox-xml.rb"
	  Then I should see:
	    """
	    Generating XML file from videos...
	    """
	  And I should not see "something I don't wanted printed"