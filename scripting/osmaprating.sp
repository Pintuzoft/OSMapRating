#include <sourcemod>
#include <sdktools>
#include <cstrike>

int rounds = 0;
Handle panel;

/*
    Plugins to let players get a panel to rate current running map from 1 to 5 stars.
    The plugin will connect to a database and store the results.
*/

public Plugin myinfo = {
	name = "OSMapRating",
	author = "Pintuz",
	description = "OldSwedes Map Rating Plugin",
	version = "0.01",
	url = "https://github.com/Pintuzoft/OSMapRating"
}

public void OnPluginStart() {
    HookEvent ( "round_start", Event_RoundStart );
    RegConsoleCmd ( "sm_ratemap", Command_MapRating, "Opens a menu to rate the current map" );
    RegConsoleCmd ( "sm_maprate", Command_MapRating, "Opens a menu to rate the current map" );
}


public Action Event_RoundStart ( Handle event, const char[] name, bool dontBroadcast ) {
    rounds++;
    if ( rounds % 6 == 0 ) {
        CreateTimer ( 1.0, Timer_RoundStart );
    }
    return Plugin_Continue;
}

public Action Timer_RoundStart ( Handle timer, any data ) {
    PrintToChatAll ( " \x04[OSMapRating]: \x01You can now rate the current map by typing !ratemap, or !ratemap 1-4" );
    return Plugin_Continue;
}

public void Command_MapRating ( int client, int args ) {
    if ( args > 1 ) {
        PrintToChat ( client, " \x04[OSMapRating]: \x01Invalid arguments, use !ratemap or !ratemap 1-4" );   
    }

    int rating = -1;
    
    if ( args == 1 ) {
        char arg1[32];
        GetCmdArg(1, arg1, sizeof(arg1));
        rating = StringToInt(arg1);

        if ( rating < 1 || rating > 4 ) {
            PrintToChat ( client, " \x04[OSMapRating]: \x01Invalid arguments, use !ratemap or !ratemap 1-4" );   
            return;
        }



    } else {
        /* SHOW VOTE PANEL */
        ShowMapRatingPanel ( client );
    }



}


public void ShowMapRatingPanel ( int client ) {
    panel = CreatePanel ( );
    SetPanelTitle ( panel, "Rate Current Map:" );
    DrawPanelText ( panel, " " );
    DrawPanelText ( panel, "Rate map between 1 and 4 where 4 is best" );
    DrawPanelText ( panel, " " );
    DrawPanelItem ( panel, "star" );
    DrawPanelItem ( panel, "stars" );
    DrawPanelItem ( panel, "stars" );
    DrawPanelItem ( panel, "stars" );
    DrawPanelText ( panel, " " );
    DrawPanelText ( panel, "Exit" );
    SendPanelToClient ( panel, client, Panel_MapRating, 5 );
    CloseHandle ( panel );
}
    

public Action Panel_MapRating ( Handle menu, MenuAction action, int client, int choice ) {
    choice++;
    if ( choice == 5 ) {
        return Plugin_Continue;
    }  

    if ( choice == 1 ) {
        PrintToChat ( client, " \x04[OSMapRating]: \x01You rated the map 1 star" );
    } else {
        PrintToChat ( client, " \x04[OSMapRating]: \x01You rated the map %d stars", choice );
    } 

    StoreMapRating ( client, choice );
    return Plugin_Continue;
}

public void StoreMapRating ( int client, int rating ) {
    /* STORE RATING IN DATABASE */



}