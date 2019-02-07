VPRP12I ;HPSC/MWA -- VPR patch 12 post install ;11/5/18 3:16pm
 ;;1.0;VIRTUAL PATIENT RECORD;**12**;Sep 01, 2011;Build 6
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; XPAR                          2263
 ;
PRE ; -- pre init
 Q
 ;
POST ; -- post init
 D PUT^XPAR("PKG","VPR VERSION",1,"1.12")
 Q
