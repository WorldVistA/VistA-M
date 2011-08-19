ORY212E ;SLC/MKB - Env Check for OR*3*212 ;2/11/08  11:06
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**212**;Dec 17, 1997;Build 24
 ;
EN ; -- Require VBECS, CPRS v27 in production
 I $$PROD^XUPROD,'$$PATCH^XPDUTL("OR*3.0*243") D
 . W !!,"CPRS v27 must be present to install this in a production system.",!
 . S XPDQUIT=1
 Q
