use "/Users/javierparada/Documents/GitHub/JavierParada.github.io/js_experiments/Chinese/dict.dta", clear

gen sp_compact = subinstr(sp," ","",.)

gen div = `"<div class="square">"' + characters + "</div>"

gen dict_1 = characters + ": " + `"""' + sp_compact + `"","'

gen dict_2 = sp_compact + ": " + `"""' + characters + `"","'
 
