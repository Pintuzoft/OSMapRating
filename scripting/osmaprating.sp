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
    if ( rounds == 2 ) {
        CreateTimer ( 1.0, Timer_RoundStart );
    }
    return Plugin_Continue;
}

public Action Timer_RoundStart ( Handle timer, any data ) {
    for ( int client = 1; client <= MaxClients; client++ ) {
        if ( IsClientInGame ( client ) ) {
            int player = GetClientOfUserId ( client );
            //  "1|2|3", "Choose an option:", "OptionChoice" 
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
            SendPanelToClient ( panel, player, Panel_MapRating, 5 );
            CloseHandle ( panel );
        }
    }
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