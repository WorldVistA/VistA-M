ORY264 ;;SLCOIFO - Pre and Post-init for patch OR*3*264 ;7/11/06  13:20
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**264**;Dec 17, 1997
PRE ; Pre-init for patch 264
 D PARVAL
 Q
PARVAL ; Set parameter values
 ; Set VistaWeb Parameter
 D EN^XPAR("PKG","ORWRP VISTAWEB ADDRESS",1,"https://vistaweb.med.va.gov/ToolsPage.aspx")
 Q
