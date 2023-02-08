#include <sourcemod>
#include <sdktools>
#include <cstrike>

int rounds = 0;

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

public void OnPluginStart ( ) {
    HookEvent ( "round_start", Event_RoundStart );
}

public void OnMapStart ( ) {
    rounds = 0;
}

public Action Event_RoundStart ( Handle event, const char[] name, bool dontBroadcast ) {
    rounds++;
    PrintToConsoleAll ( " \x04[OSMapRating]\x01: 0 Round %d", rounds );
    if ( rounds == 2 ) {
        PrintToConsoleAll ( " \x04[OSMapRating]\x01: 1 Showing panel to all players" );
        for ( int i = 1; i <= MaxClients; i++ ) {
            PrintToConsoleAll ( " \x04[OSMapRating]\x01: 2 Checking client %d", i );
            if ( IsClientInGame ( i ) ) {
                PrintToConsoleAll ( " \x04[OSMapRating]\x01: 3 Client %d is in game", i );
                Handle panel = CreatePanel ( );
                SetPanelTitle ( panel, "Rate Current Map:" );
                DrawPanelText ( panel, " " );
                DrawPanelText ( panel, "Rate map between 1 and 5" );
                DrawPanelText ( panel, " " );
                DrawPanelItem ( panel, "star" );
                DrawPanelItem ( panel, "stars" );
                DrawPanelItem ( panel, "stars" );
                DrawPanelItem ( panel, "stars" );
                DrawPanelItem ( panel, "stars" );
                DrawPanelText ( panel, " " );
                DrawPanelText ( panel, "Exit" );
                SendPanelToClient ( panel, i, Panel_MapRating, 8 );
                CloseHandle ( panel );
            }
            PrintToConsoleAll ( " \x04[OSMapRating]\x01: 4" );
        }
        PrintToConsoleAll ( " \x04[OSMapRating]\x01: 5" );
    }
    PrintToConsoleAll ( " \x04[OSMapRating]\x01: 6" );
    return Plugin_Continue;
}
 
public Panel_MapRating ( Handle menu, MenuAction action, int client, int choice ) {
    choice++;
    if ( choice > 0 && choice < 6 ) {
        PrintToChat ( client, " \x04[OSMapRating]\x01: Map got %d star(s)", choice );
        StoreMapRating ( client, choice );
    } 

}



public void StoreMapRating ( int client, int rating ) {
    /* STORE RATING IN DATABASE */




}