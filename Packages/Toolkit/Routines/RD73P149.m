RD73P149 ;RSD/OAKLAND - Test Routine for XT*7.3*149
 ;;7.3;TOOLKIT;**149**;Apr 25, 1995;Build 1
 ;This routine is only to test XINDEX for patch 149.
 ;It is in the RD namespace because XT routines allow vendor specific code
 Q
 ;This is Vendor Specific code
 ; Call web server and web service. API key is set in Context Root of the web service in HWSC.
 N SERV,PREQ,JSON
 S SERV="TEST"
 S PREQ=$$GETREST^XOBWLIB(SERV,"UAM AV SERVER")
 S JSON="TEST"
 D PREQ.EntityBody.Write(JSON) ; places the entire json string into EntityBody
 D PREQ.SetHeader("ContentType","application/json")
 ;reference variable DILOCKTM
 I DILOCKTM
 ;
 Q
