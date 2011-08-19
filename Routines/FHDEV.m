FHDEV ; HISC/REL - Device Parameters ;7/11/89  22:0 
 ;;5.5;DIETETICS;;Jan 28, 2005
 S FHIO("P10")=$P($G(^%ZIS(2,IOST(0),5)),"^",1) S:FHIO("P10")="" FHIO("P10")=""""""
 S FHIO("P16")=$P($G(^%ZIS(2,IOST(0),12.1)),"^",1) S:FHIO("P16")="" FHIO("P16")=""""""
 S FHIO("RES")=$P($G(^%ZIS(2,IOST(0),6)),"^",1) S:FHIO("RES")="" FHIO("RES")=""""""
 S FHIO("EON")=$P($G(^%ZIS(2,IOST(0),7)),"^",1) S:FHIO("EON")="" FHIO("EON")=""""""
 S FHIO("EOF")=$P($G(^%ZIS(2,IOST(0),7)),"^",2) S:FHIO("EOF")="" FHIO("EOF")=""""""
 S FHIO("DON")=$P($G(^%ZIS(2,IOST(0),408)),"^",1) S:FHIO("DON")="" FHIO("DON")=""""""
 S FHIO("DOF")=$P($G(^%ZIS(2,IOST(0),409)),"^",1) S:FHIO("DOF")="" FHIO("DOF")=""""""
 Q
