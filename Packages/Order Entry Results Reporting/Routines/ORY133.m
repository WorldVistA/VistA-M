ORY133 ;SLC/MKB - Postinit for patch OR*3*133 ;1/18/02  12:20
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**133**;Dec 17, 1997
 ;
POST ; -- postinit
 S ^ORD(101.42,99,0)="DONE^ZD",^ORD(101.42,"C","ZD",99)="" ;+abbreviation
 Q
