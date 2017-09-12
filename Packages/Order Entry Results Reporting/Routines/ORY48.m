ORY48 ;SLC/MKB-Postinit for patch OR*3*48 ;7/9/99  14:22
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**48**;Dec 17, 1997
 ;
EN ; -- set default for new parameter
 ;
 N ORX S ORX=$$GET^XPAR("ALL","OR OREMAS MED ORDERS")
 D:ORX="" EN^XPAR("SYS","OR OREMAS MED ORDERS",1,2)
 Q
