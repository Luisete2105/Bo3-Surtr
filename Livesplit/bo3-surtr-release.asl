state( "blackops3", "MS Enhanced" )
{
    float surtr : "BlackOps3.exe", 0x19A52AD8;
}
state( "blackops3", "Steam 3 March 2023" )
{
    float surtr : "BlackOps3.exe", 0x17B189A8;
}
state( "blackops3", "Steam 3 March 2023 T7 Patch" )
{
    float surtr : "BlackOps3.exe", 0x17B18A48;
}
state( "blackops3", "Steam 19 February 2026" )
{
    float surtr : "BlackOps3.exe", 0x17A99AA8;
}
state( "blackops3", "Steam 10 September 2026" )
{
    float surtr : "BlackOps3.exe", 0x17A99AC8;
}
state( "t7x", "v0.0.3 2023" )
{
    float surtr : "BlackOps3.exe", 0x17B18FE8;
}
state( "t7x", "v0.0.4 2026" )
{
    float surtr : "BlackOps3.exe", 0x17A9A0E8;
}
startup
{
    refreshRate = 20;
}
init
{
    string gameDir = Path.GetDirectoryName(modules.First().FileName);
    bool has_local_dsound = modules.Any(m =>
            m.ModuleName.Equals("dsound.dll", StringComparison.OrdinalIgnoreCase) &&
            m.FileName.StartsWith(gameDir, StringComparison.OrdinalIgnoreCase));
    string MD5Hash;
    using (var md5 = System.Security.Cryptography.MD5.Create())
    using (var s = File.Open(modules.First().FileName, FileMode.Open, FileAccess.Read, FileShare.ReadWrite))
    MD5Hash = md5.ComputeHash(s).Select(x => x.ToString("X2")).Aggregate((a, b) => a + b);
    switch (MD5Hash){
        case "A3CC39BE7AE48947CDD8443F44467261":
        {
            version = "Steam 10 September 2026";
            break;
        }        
        case "B773E637E7330474CF298220478F77AD":
        {
            version = "Steam 19 February 2026";
            break;
        }
        case "5377ADAB3FEC9EE10696C37F12768039":
        {
            version = "Steam 3 March 2023";
            if (has_local_dsound){
                version += " T7 Patch";
            }
            break;
        }
        case "F0C883CBCA2DB52440E8B8AB79B8F162":
        {
            version = "MS Enhanced";
            break;
        }
        case "50567D41011A17A93E597B6F0C1AE427":
        {
            version = "v0.0.3 2023";
            break;
        }
        case "BBA60BFE10AD1A0836B4693417B9ABBE":
        {
            version = "v0.0.4 2026";
            break;
        }
        default:
        {
            version = "Steam 10 September 2026"; 
            break;
        }
    }
} 
start
{
    if( current.surtr == 2 && old.surtr != 2 ){
        return true;        
    }
}
reset
{
    if( current.surtr == 1 && old.surtr != 1 ){
        return true;
    }
}
split
{
    if( current.surtr == 3 && old.surtr != 3 ){
        return true;
    }
}