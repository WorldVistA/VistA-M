ONCSGA8X ;Hines OIFO/RTK - AJCC 8th Ed Automatic Staging Tables ;01/16/19
 ;;2.2;ONCOLOGY;**10**;Jul 31, 2013;Build 20
 ;
 ;
1 ;
 I G=1,HER2="P",ER="P",PR="P" S SG="1A"
 I G=1,HER2="P",ER="P",PR="N" S SG="1A"
 I G=1,HER2="P",ER="N",PR="P" S SG="1A"
 I G=1,HER2="P",ER="N",PR="N" S SG="1A"
 I G=1,HER2="N",ER="P",PR="P" S SG="1A"
 I G=1,HER2="N",ER="P",PR="N" S SG="1A"
 I G=1,HER2="N",ER="N",PR="P" S SG="1A"
 I G=1,HER2="N",ER="N",PR="N" S SG=$S(STGIND="C":"1B",1:"1A")
 I G=2,HER2="P",ER="P",PR="P" S SG="1A"
 I G=2,HER2="P",ER="P",PR="N" S SG="1A"
 I G=2,HER2="P",ER="N",PR="P" S SG="1A"
 I G=2,HER2="P",ER="N",PR="N" S SG="1A"
 I G=2,HER2="N",ER="P",PR="P" S SG="1A"
 I G=2,HER2="N",ER="P",PR="N" S SG="1A"
 I G=2,HER2="N",ER="N",PR="P" S SG="1A"
 I G=2,HER2="N",ER="N",PR="N" S SG="1A"
 I G=3,HER2="P",ER="P",PR="P" S SG="1A"
 I G=3,HER2="P",ER="P",PR="N" S SG="1A"
 I G=3,HER2="P",ER="N",PR="P" S SG="1A"
 I G=3,HER2="P",ER="N",PR="N" S SG="1A"
 I G=3,HER2="N",ER="P",PR="P" S SG="1A"
 I G=3,HER2="N",ER="P",PR="N" S SG=$S(STGIND="C":"1B",1:"1A")
 I G=3,HER2="N",ER="N",PR="P" S SG=$S(STGIND="C":"1B",1:"1A")
 I G=3,HER2="N",ER="N",PR="N" S SG="1B"
 Q
 ;
2 ;
 I G=1,HER2="P",ER="P",PR="P" S SG=$S(STGIND="C":"1B",1:"1A")
 I G=1,HER2="P",ER="P",PR="N" S SG=$S(STGIND="C":"2A",1:"1B")
 I G=1,HER2="P",ER="N",PR="P" S SG=$S(STGIND="C":"2A",1:"1B")
 I G=1,HER2="P",ER="N",PR="N" S SG="2A"
 I G=1,HER2="N",ER="P",PR="P" S SG=$S(STGIND="C":"1B",1:"1A")
 I G=1,HER2="N",ER="P",PR="N" S SG=$S(STGIND="C":"2A",1:"1B")
 I G=1,HER2="N",ER="N",PR="P" S SG=$S(STGIND="C":"2A",1:"1B")
 I G=1,HER2="N",ER="N",PR="N" S SG="2A"
 I G=2,HER2="P",ER="P",PR="P" S SG=$S(STGIND="C":"1B",1:"1A")
 I G=2,HER2="P",ER="P",PR="N" S SG=$S(STGIND="C":"2A",1:"1B")
 I G=2,HER2="P",ER="N",PR="P" S SG=$S(STGIND="C":"2A",1:"1B")
 I G=2,HER2="P",ER="N",PR="N" S SG="2A"
 I G=2,HER2="N",ER="P",PR="P" S SG=$S(STGIND="C":"1B",1:"1A")
 I G=2,HER2="N",ER="P",PR="N" S SG="2A"
 I G=2,HER2="N",ER="N",PR="P" S SG="2A"
 I G=2,HER2="N",ER="N",PR="N" S SG=$S(STGIND="C":"2B",1:"2A")
 I G=3,HER2="P",ER="P",PR="P" S SG=$S(STGIND="C":"1B",1:"1A")
 I G=3,HER2="P",ER="P",PR="N" S SG="2A"
 I G=3,HER2="P",ER="N",PR="P" S SG="2A"
 I G=3,HER2="P",ER="N",PR="N" S SG="2A"
 I G=3,HER2="N",ER="P",PR="P" S SG=$S(STGIND="C":"2A",1:"1B")
 I G=3,HER2="N",ER="P",PR="N" S SG=$S(STGIND="C":"2B",1:"2A")
 I G=3,HER2="N",ER="N",PR="P" S SG=$S(STGIND="C":"2B",1:"2A")
 I G=3,HER2="N",ER="N",PR="N" S SG=$S(STGIND="C":"2B",1:"2A")
 Q
3 ;
 I G=1,HER2="P",ER="P",PR="P" S SG=$S(STGIND="C":"1B",1:"1A")
 I G=1,HER2="P",ER="P",PR="N" S SG=$S(STGIND="C":"2A",1:"2B")
 I G=1,HER2="P",ER="N",PR="P" S SG=$S(STGIND="C":"2A",1:"2B")
 I G=1,HER2="P",ER="N",PR="N" S SG="2B"
 I G=1,HER2="N",ER="P",PR="P" S SG=$S(STGIND="C":"2A",1:"1A")
 I G=1,HER2="N",ER="P",PR="N" S SG="2B"
 I G=1,HER2="N",ER="N",PR="P" S SG="2B"
 I G=1,HER2="N",ER="N",PR="N" S SG="2B"
 I G=2,HER2="P",ER="P",PR="P" S SG="1B"
 I G=2,HER2="P",ER="P",PR="N" S SG=$S(STGIND="C":"2A",1:"2B")
 I G=2,HER2="P",ER="N",PR="P" S SG=$S(STGIND="C":"2A",1:"2B")
 I G=2,HER2="P",ER="N",PR="N" S SG="2B"
 I G=2,HER2="N",ER="P",PR="P" S SG=$S(STGIND="C":"2A",1:"1B")
 I G=2,HER2="N",ER="P",PR="N" S SG="2B"
 I G=2,HER2="N",ER="N",PR="P" S SG="2B"
 I G=2,HER2="N",ER="N",PR="N" S SG="2B"
 I G=3,HER2="P",ER="P",PR="P" S SG="1B"
 I G=3,HER2="P",ER="P",PR="N" S SG="2B"
 I G=3,HER2="P",ER="N",PR="P" S SG="2B"
 I G=3,HER2="P",ER="N",PR="N" S SG="2B"
 I G=3,HER2="N",ER="P",PR="P" S SG=$S(STGIND="C":"2B",1:"2A")
 I G=3,HER2="N",ER="P",PR="N" S SG=$S(STGIND="C":"3A",1:"2B")
 I G=3,HER2="N",ER="N",PR="P" S SG=$S(STGIND="C":"3A",1:"2B")
 I G=3,HER2="N",ER="N",PR="N" S SG=$S(STGIND="C":"3B",1:"3A")
 Q
4 ;
 I G=1,HER2="P",ER="P",PR="P" S SG=$S(STGIND="C":"2A",1:"1B")
 I G=1,HER2="P",ER="P",PR="N" S SG="3A"
 I G=1,HER2="P",ER="N",PR="P" S SG="3A"
 I G=1,HER2="P",ER="N",PR="N" S SG="3A"
 I G=1,HER2="N",ER="P",PR="P" S SG=$S(STGIND="C":"2A",1:"1B")
 I G=1,HER2="N",ER="P",PR="N" S SG="3A"
 I G=1,HER2="N",ER="N",PR="P" S SG="3A"
 I G=1,HER2="N",ER="N",PR="N" S SG=$S(STGIND="C":"2B",1:"3A")
 I G=2,HER2="P",ER="P",PR="P" S SG=$S(STGIND="C":"2A",1:"1B")
 I G=2,HER2="P",ER="P",PR="N" S SG="3A"
 I G=2,HER2="P",ER="N",PR="P" S SG="3A"
 I G=2,HER2="P",ER="N",PR="N" S SG="3A"
 I G=2,HER2="N",ER="P",PR="P" S SG=$S(STGIND="C":"2A",1:"1B")
 I G=2,HER2="N",ER="P",PR="N" S SG="3A"
 I G=2,HER2="N",ER="N",PR="P" S SG="3A"
 I G=2,HER2="N",ER="N",PR="N" S SG="3B"
 I G=3,HER2="P",ER="P",PR="P" S SG=$S(STGIND="C":"2B",1:"2A")
 I G=3,HER2="P",ER="P",PR="N" S SG="3A"
 I G=3,HER2="P",ER="N",PR="P" S SG="3A"
 I G=3,HER2="P",ER="N",PR="N" S SG="3A"
 I G=3,HER2="N",ER="P",PR="P" S SG=$S(STGIND="C":"3A",1:"2B")
 I G=3,HER2="N",ER="P",PR="N" S SG=$S(STGIND="C":"3B",1:"3A")
 I G=3,HER2="N",ER="N",PR="P" S SG=$S(STGIND="C":"3B",1:"3A")
 I G=3,HER2="N",ER="N",PR="N" S SG="3C"
 Q
5 ;
 I G=1,HER2="P",ER="P",PR="P" S SG="3A"
 I G=1,HER2="P",ER="P",PR="N" S SG="3B"
 I G=1,HER2="P",ER="N",PR="P" S SG="3B"
 I G=1,HER2="P",ER="N",PR="N" S SG="3B"
 I G=1,HER2="N",ER="P",PR="P" S SG=$S(STGIND="C":"3B",1:"3A")
 I G=1,HER2="N",ER="P",PR="N" S SG="3B"
 I G=1,HER2="N",ER="N",PR="P" S SG="3B"
 I G=1,HER2="N",ER="N",PR="N" S SG=$S(STGIND="C":"3C",1:"3B")
 I G=2,HER2="P",ER="P",PR="P" S SG="3A"
 I G=2,HER2="P",ER="P",PR="N" S SG="3B"
 I G=2,HER2="P",ER="N",PR="P" S SG="3B"
 I G=2,HER2="P",ER="N",PR="N" S SG="3B"
 I G=2,HER2="N",ER="P",PR="P" S SG=$S(STGIND="C":"3B",1:"3A")
 I G=2,HER2="N",ER="P",PR="N" S SG="3B"
 I G=2,HER2="N",ER="N",PR="P" S SG="3B"
 I G=2,HER2="N",ER="N",PR="N" S SG="3C"
 I G=3,HER2="P",ER="P",PR="P" S SG="3B"
 I G=3,HER2="P",ER="P",PR="N" S SG="3B"
 I G=3,HER2="P",ER="N",PR="P" S SG="3B"
 I G=3,HER2="P",ER="N",PR="N" S SG="3B"
 I G=3,HER2="N",ER="P",PR="P" S SG="3B"
 I G=3,HER2="N",ER="P",PR="N" S SG="3C"
 I G=3,HER2="N",ER="N",PR="P" S SG="3C"
 I G=3,HER2="N",ER="N",PR="N" S SG="3C"
 Q
