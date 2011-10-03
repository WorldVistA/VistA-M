DVBHQM13 ;ISC-ALBANY/JLU ; This routine is general for space saving ;10/6/88@08:00
 ;;4.0;HINQ;**49**;03/25/92 
 ;
MRT S Z=$S(T="A":"Veterans Master Record",T="B":"Death Payee",T="C":"Apportioned Payee-Live",T="D":"Accounts Receivable or Deposit Fund",1:"")
 I Z="" S Z=$S(T="E":"Terminated Pending Purge",T="F":"Apportioned Payee-death",T="G":"PFOP Recurring Payment",T="N":"Notice of Death Record",1:"")
 Q
OLC S Z=$S(T1=0:"No losses in this group",T1=1:"Loss or loss of use of creative organ.",T1=2:"Loss or loss of use of both buttocks.",T1=3:"Loss of buttocks & loss of creative organ",1:"")
 I Z="" S Z=$S(T1=4:"Regular aid and attendance or permanently bedridden",T1=5:"Loss of creative organ & Regular A&A or bedridden",T1=6:"Loss of buttocks,creative organ Regular A&A,bedridden",1:"")
 I Z="" S Z=$S(T1=7:"Loss creative organ,buttocks Regular A&A,bedridden",1:"")
 Q
VMV S Z=$S(T1=" "!(T1=0):"No spouse or not eligible",T1=1:"Spouse WWI, MBP, included in award.",T1=2:"Spouse veteran, not of WWI or MBP, included in award.",T1="Y":"Yes",1:"")
 I Z="" S Z=$S(T1=3:"Spouse veteran WWI or MBP, paid separately. Another file number.",T1=4:"Spouse not veteran WWI or MBP, paid separately. Another file number.",1:"")
 Q
SPC S Z=$S(T1=1:"Paragraph 29",T1=2:"Paragraph 30",T1=3:"VA Regulation 1321(B)",T1=4:"VA Regulation 1322(A)",T1=5:"Analogous Ratings",T1=6:"Other or Combination",1:"")
 Q
