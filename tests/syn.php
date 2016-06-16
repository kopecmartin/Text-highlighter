#!/usr/bin/php
<?php
#SYN:xkopec42
/**
 * Project: SYN - Zvyrazneni syntaxe
 * Author: Martin Kopec
 * Login: xkopec42
 * Date: 10.03.2016
 */

/**
 * Style
 * 
 * Class for each style
 * Styles' information stored here
 */
class Style{
    //declare start, end index of style
    public function __construct(){
        $this->start_index = array();
        $this->end_index = array();
        $this->num_hex = array(); //color number/font size
    }
    /**
     * Add indexes, where style will be applicated
     * @param int $start - index for opening tag of style
     * @param int $end   - index for closing tag of style
     */
    public function add_new_indexes($start, $end){
        array_push($this->start_index, $start);
        array_push($this->end_index, $end);
    }
    //
    /**
     * Recount indexes of style - when tag is put, 
     * greater indexes must be increased
     * @param  [type] $than1 - if index is greather 
     * @param  [type] $add1    than than1 add add1
     * @param  [type] $than2 - if index is greateher
     * @param  [type] $add2    than than2 add add2
     */
    public function less_than_add($than1, $add1, $than2, $add2){
      
        foreach ($this->start_index as $i => &$index) {            
            $this->start_index[$i] =  ( $index < $than1) ?  $index : (( $index < $than2 ) ? $index+$add1 : $index+$add1+$add2);
        }
        foreach ($this->end_index as $i => &$index) {            
            $this->end_index[$i] =  ( $index <= $than1) ?  $index : (( $index <= $than2 ) ? $index+$add1 : $index+$add1+$add2);     
        }
    }
}
/**
 * Format
 * 
 * Class contains instances of Style class,
 * methods for printing tags for specific
 * style and filling Style instances by data
 */
class Format{
    //create Style instance for each style
    public function __construct(){
        $this->bold = new Style;        
        $this->italic = new Style;
        $this->underline = new Style;
        $this->teletype = new Style;
        $this->size = new Style;
        $this->color = new Style;
        $this->tags = array("bold", "italic", "underline", "teletype", "size", "color");
        $this->content = "";
        $this->tag_order = array();
    }
    /**
     * Recount indexes of all styles
     * @param  int $than1 - index where openning tag was put
     * @param  int $add1  - length of openning tag
     * @param  int $than2 - index where closeing tag was put
     * @param  int $add2  - length of closing tag
     */
    private function recount_index($than1, $add1, $than2, $add2){
        foreach ($this->tags as $tag) {
            $this->$tag->less_than_add($than1, $add1, $than2, $add2);
        }
    }
    //call function which name is stored in tag_order
    public function tags(){ 
        foreach ($this->tag_order as $i => $tag) {
            call_user_func(array($this, $tag)); 
        }
    }
    //Functions of each style define tags specific for each style and put them to $this->content
    private function bold(){
        foreach ($this->bold->start_index as $i => &$start) {
            $end = $this->bold->end_index[$i];        
            $this->content = substr_replace($this->content, "<b>", $start, 0);
            $this->content = substr_replace($this->content, "</b>", $end+3, 0);
            $this->recount_index($start, 3, $end, 4);
        }        
    }
    private function italic(){
        foreach ($this->italic->start_index as $i => &$start) {            
            $end = $this->italic->end_index[$i];
            $this->content = substr_replace($this->content, "<i>", $start, 0);
            $this->content = substr_replace($this->content, "</i>", $end+3, 0);
            $this->recount_index($start, 3, $end, 4);
        }    
    }
    private function underline(){      
        foreach ($this->underline->start_index as $i => &$start) {            
            $end = $this->underline->end_index[$i];
            $this->content = substr_replace($this->content, "<u>", $start, 0);
            $this->content = substr_replace($this->content, "</u>", $end+3, 0);
            $this->recount_index($start, 3, $end, 4);
        }   
    }
    private function teletype(){  
        foreach ($this->teletype->start_index as $i => &$start) {          
            $end = $this->teletype->end_index[$i];  
            $this->content = substr_replace($this->content, "<tt>", $start, 0);
            $this->content = substr_replace($this->content, "</tt>", $end+4, 0);
            $this->recount_index($start, 4, $end, 5);
        }  
    }  
    private function size(){    
        foreach ($this->size->start_index as $i => &$start) {   
            $end = $this->size->end_index[$i];
            $number = array_shift($this->size->num_hex);  
            $this->content = substr_replace($this->content, "<font size=".$number.">", $start, 0);
            $this->content = substr_replace($this->content, "</font>", $end+12+1, 0);
            $this->recount_index($start, 12+1, $end, 7);
        }  
    }  
    private function color(){     
        foreach ($this->color->start_index as $i => &$start) {
            $end = $this->color->end_index[$i];
            $color = array_shift($this->color->num_hex);
            $this->content = substr_replace($this->content, "<font color=#$color>", $start, 0);
            $this->content = substr_replace($this->content, "</font>", $end+14+strlen($color), 0);
            $this->recount_index($start, 14+strlen($color), $end, 7);
        }
    }
    /**
     * Fill instances of Style by data
     * @param  int $start - starting index
     * @param  int $end   - ending index
     * @param  string $styles - format-commands devided by comma
     */
    public function fill_indexes($start, $end, $styles){
        $styles = explode(',', $styles);
        foreach ($styles as $style) {
            switch ($style) {
                case "bold":     
                case "italic":
                case "underline":
                case "teletype":
                    if((array_search($style, $this->tag_order)) === FALSE){array_push($this->tag_order, $style);}
                    $this->$style->add_new_indexes($start, $end); //$style evaluates so f.e.:$this->bold->add_new_indexes().. 
                break;

                default: 
                    if((preg_match('/size:\d/', $style))){
                        if((array_search("size", $this->tag_order)) === FALSE){array_push($this->tag_order, "size");}
                        $this->size->add_new_indexes($start, $end);
                        $i = sizeof($this->size->num_hex);
                        $style = explode(":", $style);
                        $this->size->num_hex[$i] = $style[1]; #extract just the number               
                    }
                    else if((preg_match('/color:\w*/', $style))){
                        if((array_search("color", $this->tag_order)) === FALSE){array_push($this->tag_order, "color");}
                        $this->color->add_new_indexes($start, $end);
                        $i = sizeof($this->color->num_hex);     
                        $style = explode(":", $style);
                        $this->color->num_hex[$i] = $style[1]; #extract just the number
                    }
                    else{
                        handle_err(4,"WRONG format of format-command");
                    }
            }
        }
    }
}
/**
 * Check validity of format-commands,
 * if error found, exit script
 * @param  $styles - string of commands
 *                   divided by comma
 */
function check_format_command($styles){
    $styles = explode(',', $styles);
    foreach ($styles as $style) {
        switch ($style) {
            case "bold":
            case "italic":
            case "underline":
            case "teletype":
                break;
            default:
            if((preg_match('/size:\d/', $style))){
                $style = explode(":", $style);
                if((int) $style[1] < 1 or (int) $style[1] > 7){
                    handle_err(4,"WRONG size parameter");
                }             
            }
            else if((preg_match('/color:\w*/', $style))){
                $style = explode(":", $style);
                if(preg_match('/^[0-9A-Fa-f]{1,6}$/', $style[1]) != 1){
                    handle_err(4,"WRONG number of color");
                }
            }
            else{
                handle_err(4,"Unrecognised format-command");
            }
        }
    }
}
/**
 * Print to STDERR custom message 
 * and return appropriate error code number
 * @param  int $error_num - error number
 * @param  string $msg    - message
 */
function handle_err($error_num, $msg){
    fwrite(STDERR, $msg."\n");
    exit($error_num);
}
/**
 * Print help to STDOUT
 */
function help(){
    fwrite(STDOUT, "\nSYN - help:
  -execute: <script_name> [--help] [--br] [--format=<filename>] [--input=<filename>]  [--output=<filename>]
  --format -> format-file
  --input  -> input file in UTF-8 format
  --output -> output file in UTF-8 format
  --br     -> add <br /> at the and of each line\n\n");
}
/**
 * Match pattern in regex and replace it
 * according to replace array
 * @param  string $pattern 
 * @param  string $regex   
 * @param  2D array $replace 
 * @return string  - replaced regex
 */
function match_replace($pattern, $regex, $replace){
    $matches = array();
    if(preg_match_all('/'.$pattern.'/', $regex, $matches)){
        foreach ($matches[0] as $match) {
            $beg_index = strpos($regex, $match);
            $len = strlen($match);
            $match = strtr($match, $replace);
            $regex = substr_replace($regex, $match, $beg_index, $len);
            }
    }
    return $regex;
}
/**
 * Examine if regex is valid and hash 
 * it to original regex
 * @param  string $regex
 * @return string  - hashed regex
 */
function hash_regex($regex){
    //invalid regular expressions
    $bad="(?<!%)\|\||(?<!%)\(\)|(?<!%)\(\||(?<!%)\|\)|(?<!%)!$|!\+|!\*|(?<!%)!\||(?<!%)!\)|";
    $bad=$bad."(?<!%)\|$|^\||(?<!%)\.\)|^\+|^\*|^\)";
    if(preg_match('/'.$bad.'/', $regex)){ 
        handle_err(4,"WRONG format of regex1");
    }

    //edit kvantifikators
    $regex = preg_replace(array('/\*{2,}/', '/\+{2,}/','/(\+|\*)?(\+\*|\*\+)+(\+|\*)?/'), array('*','+','*'), $regex);
    
    //edit duplicity of !
    if(preg_match_all('/!!+/', $regex, $matches)){
        foreach ($matches[0] as $match) {
            if(strlen($match) % 2 == 0){
                $regex = str_replace($match, "", $regex);
            }else{
                $regex = str_replace($match, "!", $regex);
            }
        }
    }
    //original RE
    $regex = strtr($regex, array( "[" => "\[",  "]" => "\]", "{" => "\{",
                                  "}" => "\}",  "^" => "\^", "$" => "\\$",
                                  "?" => "\?",  "\\n" => "\\\\n",
                                  "\\t" =>"\\\\t","\d" => "\\\\d",
                                  "\s" => "\\\\s", "/" => "\/", "\\" => "\\\\"));  
    //RE exclamation mark
    if(preg_match_all('/(?<!%)!\(/', $regex, $matches)){
        foreach ($matches[0] as $match) {
            $beg_index = strpos($regex, $match);
            $counter = 1; //counter of brackets ( => +; ) => - // already 1 because match contains (
            $beg_index = $beg_index + 2; //now beg_index is index of char behind !( 
            $length = strlen($regex);
            for ($i=$beg_index; $i < $length; $i++) { 
                if($regex[$i] == '('){ $counter++; }
                if($regex[$i] == ')'){ $counter--; }
                if($counter == 0){
                    break;
                }
            }
            if($counter != 0){ handle_err(4, "WRONG format of regex3"); }//brackets mismatch

            $match = "[^".substr($regex, $beg_index-1, $i - ($beg_index-2))."]";
            $regex = substr_replace($regex, $match, $beg_index-2, $i - ($beg_index-2) +1);
        }
    }
    if(preg_match_all('/(?<!%)!%.|(?<!%)!./', $regex, $matches)){
        foreach ($matches[0] as $match) {
            $beg_index = strpos($regex, $match);
            $len = strlen($match);
            $match = str_replace($match, "[^".str_replace("!", "", $match)."]",$match);
            $regex = substr_replace($regex, $match, $beg_index, $len);         
        }
    }    
    //hash dot
    if(preg_match_all('/[^\.|\%|\(]\.[^\.|\+|\*]/', $regex, $matches)){ //before . can't be + when it's alone f.e.: +.
        foreach ($matches[0] as $match) {
            $beg_index = strpos($regex, $match);
            $len = strlen($match);
            $match = str_replace($match, str_replace(".", "", $match),$match);
            $regex = substr_replace($regex, $match, $beg_index, $len);         
        }
    }
    if(preg_match('/(?<!%)\./', $regex)){ handle_err(4,"WRONG format of format command"); }
    
    //special SYN characters
    $regex = match_replace('(?<!%)%(s|a|d|l|L|w|W|t|n)',$regex, array("%s" => "\s",
                                                                      "%a" => "(.|\s)",
                                                                      "%d" => "\d",
                                                                      "%l" => "[a-z]",
                                                                      "%L" => "[A-Z]",
                                                                      "%w" => "[a-zA-Z]",
                                                                      "%W" => "[a-zA-Z0-9]",
                                                                      "%t" => "\t",
                                                                      "%n" => "\n"));
   $regex = match_replace('(?<![^%]%)%(\.|!|\||\*|\+|\(|\))', $regex,
            array("%." => "\.", "%!" => "!",
                  "%|" => "\|", "%*" => "\*", "%+" => "\+",
                  "%(" => "\(", "%)" => "\)" ));            
   
    //edit duplicity of %
    if(preg_match_all('/%+/', $regex, $matches)){
    $offset = 0;
    foreach ($matches[0] as $match) {
        if(strlen($match) % 2 == 0){           
            $start = strpos($regex, $match,$offset);
            $offset = strlen($match);
            $regex = substr_replace($regex, str_repeat("%", strlen($match)/2), $start,strlen($match));
            $end = $start + strlen($match);
        }else{
            handle_err(4,"WRONG format of regex2");
        }
    }
}
    return $regex;
}

////------------MAIN------------////
#init
$F = new Format;
$matches = array();

#no arguments
if ($argc == 1){
    fwrite(STDOUT, file_get_contents("php://stdin"));
    exit(0);
}

#parse arguments
$ok_args = array("--help", "--br", "--format", "--input", "--output" );
$arguments = array();
foreach ($argv as $arg) {
    $arg = explode("=", $arg, 2);
    $arguments[$arg[0]] = (sizeof($arg) > 1) ? $arg[1] :NULL;
}

array_shift($arguments);    //get rid of name of script
$counter = 0;

#check if got right arguments
foreach ($arguments as $arg => $val) {
    if(array_search($arg, $ok_args) !== false){
        $counter +=1;
    }
}
if($counter != $argc -1){
    handle_err(1,"Wrong arguments");
}

#check for help argument
if (array_key_exists("--help", $arguments)){
    if($argc == 2 and $arguments["--help"] == NULL){
        help();
        exit(0);
    }
    else{
        handle_err(1,"Wrong arguments");
    }
}

#check if br argument is present
$BR = FALSE;
if (array_key_exists("--br", $arguments)){
    if($arguments["--br"] != NULL){
        handle_err(1,"Wrong arguments");
    }
    $BR = TRUE;
} 

#handle source of input
if(array_key_exists("--input", $arguments)){
    if($arguments["--input"] == NULL){ handle_err(1,"Wrong arguments"); }
    if(! ($input = @fopen($arguments['--input'], 'r')) ){     // @ - hide PHP Warning
        handle_err(2, "Can't open the file");
    }
    $F->content = stream_get_contents($input);
    fclose($input);
}else{
    $F->content = file_get_contents("php://stdin"); 
}

#handle target of output
if(array_key_exists("--output", $arguments)){ 
    if($arguments["--output"] == NULL){ handle_err(1,"Wrong arguments"); }
    if(! ($output = @fopen($arguments["--output"], 'w')) ){     //returns false when error 
        handle_err(3,"Can't create a file");
    }
}else{
    $output = fopen("php://stdout", 'a'); 
}

#handle source of format input
if(array_key_exists("--format", $arguments)){
    if(!($format = @fopen($arguments["--format"], 'r'))) { //can't open the file
        if($BR){ $F->content = str_replace("\n", "<br />\n", $F->content);}
        fwrite($output, $F->content);
        exit(0);
    }
    if(filesize($arguments["--format"]) == 0){     //empty format file
        if($BR){ $F->content = str_replace("\n", "<br />\n", $F->content);}
        fwrite($output, $F->content);
        exit(0);
    }
}else{
    fwrite($output, $F->content);
    exit(0);
}

#get regular expressions and format commands
$format_array = array();

while ($regex = fgets($format)){ //load format source
    $regex = explode("\t", $regex,2); //2 = limit of size of created array, just first tab use as delimiter
   
    if(empty($regex[0])){ handle_err(4,"EMPTY RE"); }
    $regex[0] = hash_regex($regex[0]);     
    $format_array[ $regex[0] ] = preg_replace('/\s\s*/','', $regex[1]);
}

#iterate through each regex
foreach ($format_array as $regex => $style) {

    if((@preg_match_all('/'.$regex.'/', $F->content, $matches)) === false ){  //matches = all matched occurrences
        handle_err(4,"BAD syntax of regular expression");
    }
    //check validity of format-commands
    check_format_command($format_array[$regex]);

    $start = 0;
    foreach ($matches[0] as $match) {            //iterate through matches and fill indexes        
        if(strlen($match) > 0){                
            $start = strpos($F->content, $match, $start);
    
            $F->fill_indexes($start, $start + strlen($match), $format_array[$regex]);
            //increase because of offset in strpos method
            $start = $start +strlen($match);   
        }             
    }
}

#put tags into text
$F->tags();
#if BR true, put <br /> tags at the end of each line
if($BR){ 
    $F->content = str_replace("\n", "<br />\n", $F->content);
}
#put formated input out
fwrite($output, $F->content);
exit(0);
?>