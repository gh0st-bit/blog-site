import { NextResponse } from 'next/server';
import { mockDb } from '@/lib/mockdb';
import { MongoClient } from 'mongodb';

// Try to import MongoDB, fall back to mock if not available
let clientPromise: Promise<MongoClient> | null = null;
try {
  const { default: mongoClientPromise } = await import('@/lib/mongodb');
  clientPromise = mongoClientPromise;
} catch (error) {
  console.log('MongoDB not available, using mock database', error);
}

export async function GET() {
  try {
    // Try MongoDB first, fall back to mock
    if (clientPromise && process.env.MONGODB_URI) {
      try {
        const client = await clientPromise;
        const db = client.db();
        const posts = await db.collection('posts').find({}).toArray();
        return NextResponse.json(posts);
      } catch (mongoError) {
        console.log('MongoDB connection failed, using mock database:', mongoError);
      }
    }
    
    // Use mock database as fallback
    const posts = await mockDb.findAll();
    return NextResponse.json(posts);
  } catch (error) {
    console.error('Error fetching posts:', error);
    return NextResponse.json({ error: 'Failed to fetch posts' }, { status: 500 });
  }
}

export async function POST(request: Request) {
  try {
    const data = await request.json();
    
    // Try MongoDB first, fall back to mock
    if (clientPromise && process.env.MONGODB_URI) {
      try {
        const client = await clientPromise;
        const db = client.db();
        const result = await db.collection('posts').insertOne(data);
        return NextResponse.json(result);
      } catch (mongoError) {
        console.log('MongoDB connection failed, using mock database:', mongoError);
      }
    }
    
    // Use mock database as fallback
    const result = await mockDb.create(data);
    return NextResponse.json(result);
  } catch (error) {
    console.error('Error creating post:', error);
    return NextResponse.json({ error: 'Failed to create post' }, { status: 500 });
  }
}
