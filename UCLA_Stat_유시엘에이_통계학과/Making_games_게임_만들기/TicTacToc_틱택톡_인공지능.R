# Daniel Chung, tic-tac-toe

triples <- list(
  c(1,2,3),
  c(4,5,6),
  c(7,8,9),
  c(1,4,7),
  c(2,5,8),
  c(3,6,9),
  c(1,5,9),
  c(3,5,7)
)
winner <- FALSE
state <- as.character(1:9)
5+5
display = function(state){
  cat("", state[1], "|", state[2], "|", state[3], "\n")
  cat("---------", "\n")
  cat("", state[4], "|", state[5], "|", state[6], "\n")
  cat("---------", "\n")
  cat("", state[7], "|", state[8], "|", state[9], "\n")
}


check_winner<- function(state){
  for(i in 1:8){
  if(sum(triples[[i]]%in% which(state == "x")) == 3){
    cat("x player is the winner") 
    winner =TRUE
    break
  }
  }  
  for(i in 1:8){
  if(sum(triples[[i]]%in% which(state== "o"))==3){
    cat("o player is the winner")
    winner = TRUE
  break
  } 
  }  
  if(length(state[state =="x"])+ length(state[state=="o"]) == 9){
  cat("game is draw, type play() again to play another game")
  winner =TRUE   
  }
  return(winner)  
  }
update<-function(state, who, pos){
  if(who == 1){
    state[pos] <- "x"
  }
  if(who == 2){
    state[pos] <- "o"
  }
  return(state)
}


prompt_user <- function(who, state){
  illegal =TRUE
  while(illegal == TRUE){
    pos <- as.double(readline("which position to play?:"))
    if(sum(pos == 1:9) == 0){
      cat("Please choose a number from 1 to 9", "\n")
    }
  else{
    if(state[pos]== "x" | state[pos] =="o"){
      cat("this number is already used. Try different number", "\n")
    } else if(state[pos] != "x" && state[pos] != "o"){
     update(state,who,pos)
      illegal = FALSE
    }
  }
    }
return(pos)
  }



human_v_human <- function(who,state){
  while(winner ==FALSE ){
    pos <- prompt_user(who, state)
    if(who == 1){
    state <- update(state, who, pos)
    display(state)
    winner <- check_winner(state)
    who = 2
    }
    else if(who == 2){
    state <- update(state, who , pos)
    display(state)
    winner <- check_winner(state)
    who =1
    }
    }
}




computer_turn<-function(state){
  if(sum(state=="x") > sum(state=="o")){  
    before<-state
    for(i in 1:length(triples)){
      if(sum(state[triples[[i]]] == "o") == 2 && any(state[triples[[i]]] != "x")){  
        state[triples[[i]][which((triples[[i]] %in% which(state=="o"))==FALSE)]]<-"o"
      }
      if(identical(state,before)==FALSE)break
    }
    if(identical(state,before)==TRUE){
      for(i in 1:length(triples)){
        if(sum(state[triples[[i]]] == "x")==2 && any(state[triples[[i]]]!="o")){
          state[triples[[i]][which((triples[[i]] %in% which(state=="x"))==FALSE)]]<-"o"
        }
        if(identical(state,before)==FALSE)break
      }
    }
    if(identical(state,before)==TRUE){state[sample(which(state == as.character(1:9)),1)]<-"o"}
  }else if(sum(state=="o") >= sum(state=="x") || sum(state=="o")==0){
    before<-state
    for(i in 1:length(triples)){
      if(sum(state[triples[[i]]] == "x") == 2  && any(state[triples[[i]]] != "o")){
        state[triples[[i]][which((triples[[i]] %in% which(state=="x"))==FALSE)]]<-"x"
      }
      if(identical(state,before)==FALSE)break
    }
    if(identical(state,before)==TRUE){
      for(i in 1:length(triples)){
        if(sum(state[triples[[i]]] == "o")==2 && any(state[triples[[i]]] != "x")){
          state[triples[[i]][which((triples[[i]] %in% which(state=="o"))==FALSE)]]<-"x"
        }
        if(identical(state,before)==FALSE)break
      }
    }
    if(identical(state,before)==TRUE){state[sample(which(state == as.character(1:9)),1)]<-"x"}
  }
  return(state)
} 

human_verse_computer<-function(state,who){
  while(winner == FALSE){
    if(who==1){
      pos<-prompt_user(who, state)
      state<-update(state, who, pos) 
      display(state) 
      winner<-check_winner(state)
      if(winner) break
      state<-computer_turn(state)
      cat("computer's turn", "\n")
      display(state)
      winner<-check_winner(state)
    }
    else if(who==2){
      state<-computer_turn(state)
      cat("computer's turn", "\n")
      display(state) 
      winner<-check_winner(state)
      if(winner) break
      pos<-prompt_user(who, state)
      state<-update(state, who, pos)
      display(state)
      winner<-check_winner(state)
    }
  }
}

play <- function(){
  pvp_cvp <-readline("how many players? (type 1 or 2):")
  if(pvp_cvp == 1){
    who <- readline("type 1 to go first or type 2 to go second:")
    display(state)
    human_verse_computer(state, who)
  } else if(pvp_cvp == 2){
    who =1
  cat("it is x turn", "\n")
  display(state)
  human_v_human(who,state)
  winner <- check_winner(state)
  }
}


play()



