const https = require('https');

// A script to verify a list of references using the Crossref REST API
// It takes a JSON array of reference strings from stdin and outputs a JSON array of results.

async function queryCrossref(refString) {
  return new Promise((resolve, reject) => {
    const query = encodeURIComponent(refString);
    const url = `https://api.crossref.org/works?query.bibliographic=${query}&rows=1&mailto=editor@vjst.vn`;

    https.get(url, { headers: { 'User-Agent': 'GeminiCLI-ReferenceChecker/1.0 (mailto:editor@vjst.vn)' } }, (res) => {
      let data = '';
      res.on('data', (chunk) => data += chunk);
      res.on('end', () => {
        try {
          const parsed = JSON.parse(data);
          if (parsed.message && parsed.message.items && parsed.message.items.length > 0) {
            const item = parsed.message.items[0];
            resolve({
              original: refString,
              found: true,
              title: item.title ? item.title[0] : null,
              author: item.author ? item.author.map(a => `${a.given} ${a.family}`).join(', ') : null,
              year: item.issued && item.issued['date-parts'] && item.issued['date-parts'][0] ? item.issued['date-parts'][0][0] : null,
              doi: item.DOI,
              score: item.score
            });
          } else {
             resolve({ original: refString, found: false });
          }
        } catch (e) {
          resolve({ original: refString, found: false, error: 'JSON parse error' });
        }
      });
    }).on('error', (e) => {
      resolve({ original: refString, found: false, error: e.message });
    });
  });
}

async function main() {
  let inputData = '';
  process.stdin.setEncoding('utf-8');
  
  process.stdin.on('readable', () => {
    let chunk;
    while ((chunk = process.stdin.read()) !== null) {
      inputData += chunk;
    }
  });

  process.stdin.on('end', async () => {
    try {
      const references = JSON.parse(inputData.trim());
      if (!Array.isArray(references)) {
         throw new Error("Input must be a JSON array of strings.");
      }
      
      const results = [];
      for (const ref of references) {
        const result = await queryCrossref(ref);
        results.push(result);
        // Small delay to be polite to Crossref API
        await new Promise(r => setTimeout(r, 200)); 
      }
      
      console.log(JSON.stringify(results, null, 2));
    } catch (error) {
      console.error(JSON.stringify({ error: error.message }));
      process.exit(1);
    }
  });
}

main();
