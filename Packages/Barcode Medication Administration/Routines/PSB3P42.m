PSB3P42 ;BIRMINGHAM/GN - POST INSTALL FOR P242 ;7/8/10 12:48pm
 ;;3.0;BAR CODE MED ADMIN;**42**;Mar 2004;Build 23
 ;
 ; Update XPAR System parameter PSB PATIENT ID LABEL
 ;
 ; If AGENCY CODE = "I" & SYS variable = Null then set to "HRN".
 ; If AGENCY CODE '="I" then set to "SSN".
 ;
BEGIN ;
 D INITSYS("PSB PATIENT ID LABEL")
 Q
 ;
INITSYS(NAM) ; Initialize SYS value if not already populated
 I $G(DUZ("AG"))="I" D  Q
 . Q:$$GET^XPAR("SYS",NAM)'=""
 . D EN^XPAR("SYS",NAM,1,"HRN")
 D EN^XPAR("SYS",NAM,1,"SSN")
 Q
