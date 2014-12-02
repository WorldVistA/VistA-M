VPRP2I ;SLC/MKB -- VPR patch 2 post install ;8/14/13  11:22
 ;;1.0;VIRTUAL PATIENT RECORD;**2**;Sep 01, 2011;Build 317
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; XPAR                          2263
 ;
PRE ; -- pre init
 Q
 ;
POST ; -- post init
 D PUT^XPAR("PKG","VPR VERSION",1,"1.02")
 D PUT^XPAR("SYS","VPR SYSTEM NAME",1,$$SYS^VPRUTILS)
 Q
