ENWOD3 ;(WASH ISC)/DLM/DH-Formatted Work Order Display ;1.28.97
 ;;7.0;ENGINEERING;**35**;Aug 17, 1993
 ;  Print mid-section of work order
TOP4 W ! D W(" 8) ") W "CONTACT: " D:EN(8)]"" W(EN(8)) W ?39 D W(" 9) ") W "PHONE: " D:EN(9)]"" W(EN(9))
 W ! D W("10) ") W "ENTERED BY: " D W(EN(10)) W ?39 D W("11) ") W "SHOP: " D W(EN(11))
 W ! D W("12) ") W "DATE ASSIGNED: " S X=EN(12) D PDT
 W ?39 D W("13) ") W "PRIORITY: " D W(EN(13))
 W ! D W("14) ") W "EQUIP ID#: " D:EN(14)]"" W(EN(14)) W ?39 D W("15) ") W "LOCAL ID: " D:EN(15)]"" W(EN(15))
 W ! D W("16) ") W "EQUIP CAT: " D:EN(16)]"" W($E(EN(16),1,30))
 W ?49 D W("17) ") W "CONDITION: " D:EN(17)]"" W(EN(17))
 W ! D W("18) ") W "MFGR: " D:EN(18)]"" W(EN(18))
 W ! D W("19) ") W "MODEL: " D:EN(19)]"" W(EN(19)) W ?39 D W("20) ") W "SERIAL #: " D:EN(20)]"" W(EN(20))
 I EN(21)'="",$D(^DIC(49,EN(21),0)) S EN(21)=$E($P(^(0),U),1,40)
 W ! D W("21) ") W "OWNER/DEPT: " D:EN(21)]"" W(EN(21)) W ?49 D W("22) ") W "PM #: " D:EN(22)]"" W(EN(22))
 W ! D W("23) ") W "PARTS ORDER: " I EN(23)]"",$D(^PRCS(410,EN(23),0)) D W($P(^(0),U))
 W ?39 D W("24) ") W "WORK ACTION: " D:EN(24)]"" W(EN(24))
 Q
 ;
PDT I X]"" D W($E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3))
 Q
 ;
W(ENDATA) ;  Bold ENDATA
 N X
 S X=$X W IOINHI S $X=X W ENDATA
 S X=$X W IOINLOW S $X=X
 Q
 ;ENWOD3
