VPRP13I ;HPSC/MWA -- VPR patch 13 post install ; 1/18/19 1:16pm
 ;;1.0;VIRTUAL PATIENT RECORD;**13**;Sep 01, 2011;Build 1
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; XPAR                          2263
 ;
PRE ; -- pre init
 Q
 ;
POST ; -- post init
 D PUT^XPAR("PKG","VPR VERSION",1,"1.13")
 Q
