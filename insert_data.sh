#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
  echo $($PSQL "TRUNCATE games, teams")

  cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
  do
    if [[ $YEAR != "year" ]]
      then
      
      #get winner team_id
      TEAM_WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
      if [[ -z $TEAM_WINNER_ID ]]
      then
        INSERT_TEAMS_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
        TEAM_WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
      fi

      #get opponent team_id
      TEAM_OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
      if [[ -z $TEAM_OPPONENT_ID ]]
      then
        INSERT_TEAMS_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")
        TEAM_OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
      fi

      #get game
      GAME_ID=$($PSQL "SELECT game_id FROM games WHERE year='$YEAR' AND opponent_id='$TEAM_OPPONENT_ID' AND winner_id='$TEAM_WINNER_ID' AND winner_goals='$WINNER_GOALS' AND opponent_goals='$OPPONENT_GOALS' AND round='$ROUND'")
      if [[ -z $GAME_ID ]]
      then
        INSERT_GAME_RESULT=$($PSQL "INSERT INTO games(year,opponent_id,winner_id,winner_goals,opponent_goals,round) VALUES('$YEAR','$TEAM_OPPONENT_ID','$TEAM_WINNER_ID','$WINNER_GOALS','$OPPONENT_GOALS','$ROUND')")
        GAME_ID=$($PSQL "SELECT * FROM games WHERE year='$YEAR' AND opponent_id='$TEAM_OPPONENT_ID' AND winner_id='$TEAM_WINNER_ID' AND winner_goals='$WINNER_GOALS' AND opponent_goals='$OPPONENT_GOALS' AND round='$ROUND'")
      fi

      echo $GAME_ID
    fi
  done
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"

  echo $($PSQL "TRUNCATE games, teams")

  cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
  do
    if [[ $YEAR != "year" ]]
      then
      
      #get winner team_id
      TEAM_WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
      if [[ -z $TEAM_WINNER_ID ]]
      then
        INSERT_TEAMS_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
        TEAM_WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
      fi

      #get opponent team_id
      TEAM_OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
      if [[ -z $TEAM_OPPONENT_ID ]]
      then
        INSERT_TEAMS_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")
        TEAM_OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
      fi

      #get game
      GAME_ID=$($PSQL "SELECT game_id FROM games WHERE year='$YEAR' AND opponent_id='$TEAM_OPPONENT_ID' AND winner_id='$TEAM_WINNER_ID' AND winner_goals='$WINNER_GOALS' AND opponent_goals='$OPPONENT_GOALS' AND round='$ROUND'")
      if [[ -z $GAME_ID ]]
      then
        INSERT_GAME_RESULT=$($PSQL "INSERT INTO games(year,opponent_id,winner_id,winner_goals,opponent_goals,round) VALUES('$YEAR','$TEAM_OPPONENT_ID','$TEAM_WINNER_ID','$WINNER_GOALS','$OPPONENT_GOALS','$ROUND')")
        GAME_ID=$($PSQL "SELECT * FROM games WHERE year='$YEAR' AND opponent_id='$TEAM_OPPONENT_ID' AND winner_id='$TEAM_WINNER_ID' AND winner_goals='$WINNER_GOALS' AND opponent_goals='$OPPONENT_GOALS' AND round='$ROUND'")
      fi
    fi
  done
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
