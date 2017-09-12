VPRP5I ;SLC/MKB -- VPR patch 5 post install ;8/14/13  11:22
 ;;1.0;VIRTUAL PATIENT RECORD;**5**;Sep 01, 2011;Build 21
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; XPAR                          2263
 ;
PRE ; -- pre init
 Q
 ;
POST ; -- post init
 D PUT^XPAR("PKG","VPR VERSION",1,"1.05")
 Q
