import { serve } from "./deps.ts";
import { api_test } from "api/api.ts";
import { dep_test } from "dependencies/dependencies.ts";

async function handler(req: Request): Promise<Response> {
  // console.log("Method:", req.method);

  const url = new URL(req.url);
  console.log("Path:", url.pathname);
  // console.log("Query parameters:", url.searchParams);
  // console.log("Headers:", req.headers);
  
  // const body = await req.text();
  let name = "V1";
  dep_test();
  api_test();

  return new Response(`Hello, World! PH v1 ${name}`);
}

serve(handler, {port: 3000});
