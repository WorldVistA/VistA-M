ONCX ;HCIOFO/SG - HTTP AND WEB SERVICES ; 5/14/04 10:59am
 ;;2.11;ONCOLOGY;**40**;Mar 07, 1995
 ;
 ; API ENTRY POINTS ---- DESCRIPTIONS
 ;
 ;   $$GETURL^ONCX10     Gets the data from the provided URL
 ;
 ;       DEMO^ONCXDEM    Demonstartion entry point
 ;
 ; TOOLS --------------- DESCRIPTIONS
 ;
 ;  $$RECEIVE^ONCX10A    Reads the HTTP response
 ;  $$REQUEST^ONCX10A    Sends the HTTP request
 ;
 ; UTILITIES ----------- DESCRIPTIONS
 ;
 ;    $$ERROR^ONCXERR    Generates an error message
 ;      $$MSG^ONCXERR    Returns the text and type of the message
 ;     $$TYPE^ONCXERR    Returns type of the message
 ;
 ;   $$CREATE^ONCXURL    Creates a URL from components
 ;   $$ENCODE^ONCXURL    Encodes the string
 ;    $$PARSE^ONCXURL    Parses the URL into components
 ;     $$PATH^ONCXURL    Default path processing (normalization)
 ;
 ; INITIALS ------------ DEVELOPER
 ;
 ; SG                    Sergey Gavrilov
 ;
 Q
 ;
 ;***** DEMO ENTRY POINT
DEMO ;
 G DEMO^ONCXDEM
