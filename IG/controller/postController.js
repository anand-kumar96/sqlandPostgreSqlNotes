const pool = require("../pool");

exports.getAllPosts = async(req,res)=>{
    const {rows} = await pool.query(`
    SELECT * FROM posts;
    `);
    // console.log(rows);
    res.send(`
    <table>
      <thead>
        <tr>
            <th>id</th>
            <th>lng</th>
            <th>lat</th>
        </tr>
      </thead>
      <tbody>
        ${rows.map((row)=> {
            return `
                <tr>
                    <td>${row.id}</td>
                    <td>${row.loc.x}</td>
                    <td>${row.loc.y}</td>
                </tr>
            `;
        }).join('')}
      </tbody>
    </table>

    <form method = "POST">
        <h3> Craete Post </h3>
        <div>
            <label>lng</label>
            <input name ="lng"/>
        </div>
        <div>
            <label>lat</label>
            <input name ="lat"/>
        </div>
        <button type="submit">Create</button>
    </form>
    `)
}

exports.createPost = async(req,res)=>{
    const{lng,lat} = req.body;
    await pool.query(`
    INSERT INTO posts(loc) 
    VALUES ($1);`,
    [`(${lng}, ${lat})`]
    );
    res.redirect('/posts');
}