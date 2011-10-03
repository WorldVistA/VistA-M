ORY294 ;SLC/JMH - post install routine for patch OR*3*294; ;7/2/08  07:42
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**294**;Dec 17, 1997;Build 27
 ;
POST ;
 D REGREST^XOBWLIB("CDS WEB SERVICE","cds-wsclient/cds-service","/isAlive")
 Q
 ;
